#include "apiclient.h"

ApiClient *ApiClient::m_instance = nullptr;

ApiClient *ApiClient::instance()
{
    if (!m_instance) {
        m_instance = new ApiClient();
    }
    return m_instance;
}

ApiClient::ApiClient(QObject *parent) : QObject(parent)
{
    m_manager = new QNetworkAccessManager(this);
}

void ApiClient::loadToken()
{
    QSettings settings;
    m_token = settings.value("auth/token").toString();
}

void ApiClient::clearToken()
{
    m_token = "";
    QSettings settings;
    settings.remove("auth/token");
}

void ApiClient::attachToken(QNetworkRequest &request)
{
    if (!m_token.isEmpty()) {
        request.setRawHeader("Authorization", "Bearer " + m_token.toUtf8());
    }
}

void ApiClient::get(const QString &url, QJSValue callback)
{
    QNetworkRequest request(url);
    attachToken(request);
    sendRequest(request, QByteArray(), QNetworkAccessManager::GetOperation, callback);
}

void ApiClient::post(const QString &url, const QJsonObject &data, QJSValue callback){
    QNetworkRequest req{ QUrl(url) };       // <-- braces instead of parentheses
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    attachToken(req);

    QNetworkReply *reply = m_manager->post(req, QJsonDocument(data).toJson());
    connect(reply, &QNetworkReply::finished, this, [this, reply, callback]{
        QJsonObject res = handleResponse(reply);
        if(callback.isCallable())
            callback.call(QJSValueList{ QJSValue(QString::fromUtf8(QJsonDocument(res).toJson())) });
        reply->deleteLater();
    });
}

void ApiClient::put(const QString &url, const QJsonObject &data, QJSValue callback)
{
    QNetworkRequest request(url);
    attachToken(request);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QByteArray body = QJsonDocument(data).toJson();
    sendRequest(request, body, QNetworkAccessManager::PutOperation, callback);
}

void ApiClient::deleteMethod(const QString &url, QJSValue callback)
{
    QNetworkRequest request(url);
    attachToken(request);
    sendRequest(request, QByteArray(), QNetworkAccessManager::DeleteOperation, callback);
}

void ApiClient::sendRequest(const QNetworkRequest &request, const QByteArray &data, QNetworkAccessManager::Operation op, QJSValue callback)
{
    QNetworkReply *reply;
    switch (op) {
    case QNetworkAccessManager::GetOperation:
        reply = m_manager->get(request);
        break;
    case QNetworkAccessManager::PostOperation:
        reply = m_manager->post(request, data);
        break;
    case QNetworkAccessManager::PutOperation:
        reply = m_manager->put(request, data);
        break;
    case QNetworkAccessManager::DeleteOperation:
        reply = m_manager->deleteResource(request);
        break;
    default:
        if (callback.isCallable()) {
            QJSValueList args;
            args.append(QJSValue("Invalid operation"));
            callback.call(args);
        }
        return;
    }

    connect(reply, &QNetworkReply::finished, this, [reply, callback, this]() -> void {
        QJsonObject response = handleResponse(reply);
        if (callback.isCallable()) {
            QJSValueList args;
            args.append(QJSValue(QString("Invalid operation")));// Use QJSValue constructor from QVariant (QVariantMap)
            callback.call(args);
        }
        reply->deleteLater();
    });
}

QJsonObject ApiClient::handleResponse(QNetworkReply *reply)
{
    QJsonObject response;
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray data = reply->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        if (!doc.isNull()) {
            response = doc.object();
        } else {
            response["success"] = false;
            response["message"] = "Invalid JSON response";
        }
    } else {
        response["success"] = false;
        response["message"] = reply->errorString();
        response["code"] = QString::number(reply->error());
    }
    return response;
}

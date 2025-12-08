#ifndef APICLIENT_H
#define APICLIENT_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QSettings>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QVariant>
#include <QJSEngine>

class ApiClient : public QObject
{
    Q_OBJECT

public:
    static ApiClient *instance();

    Q_INVOKABLE void get(const QString &url, QJSValue callback);
    Q_INVOKABLE void post(const QString &url, const QJsonObject &data, QJSValue callback);
    Q_INVOKABLE void put(const QString &url, const QJsonObject &data, QJSValue callback);
    Q_INVOKABLE void deleteMethod(const QString &url, QJSValue callback);

    void loadToken();
    void clearToken();

signals:
    void errorOccurred(const QString &error);

private:
    explicit ApiClient(QObject *parent = nullptr);
    static ApiClient *m_instance;

    QNetworkAccessManager *m_manager;
    QString m_token;

    void sendRequest(const QNetworkRequest &request, const QByteArray &data, QNetworkAccessManager::Operation op, QJSValue callback);
    QJsonObject handleResponse(QNetworkReply *reply);
    void attachToken(QNetworkRequest &request);
};

#endif // APICLIENT_H

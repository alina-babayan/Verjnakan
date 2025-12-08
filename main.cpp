// #include <QGuiApplication>
// #include <QQmlApplicationEngine>
// #include <QQmlContext>
// #include <QUrl>
// #include <QSettings>
// #include "ApiClient.h"
// int main(int argc, char *argv[])
// {
// #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
//     QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
// #endif
//     QGuiApplication app(argc, argv);
//     QQmlApplicationEngine engine;
//     QQmlContext *context = engine.rootContext();
//     context->setContextProperty("apiClient", ApiClient::instance());
//     ApiClient::instance()->loadToken();
//     const QUrl url(QStringLiteral("qrc:/new/prefix1/main.qml"));
//     QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                      &app, [url](QObject *obj, const QUrl &objUrl) {
//                          if (!obj && url == objUrl)
//                              QCoreApplication::exit(-1);
//                      }, Qt::QueuedConnection);
//     engine.load(url);
//     return app.exec();
// }
// #include <QGuiApplication>
// #include <QQmlApplicationEngine>
// #include <QQmlContext>
// #include <QUrl>
// #include <QSettings>

// #include "apiclient.h"
// #include "ApiEndPoints.h"

// int main(int argc, char *argv[])
// {
// #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
//     QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
// #endif

//     QGuiApplication app(argc, argv);

//     QQmlApplicationEngine engine;
//     QQmlContext *context = engine.rootContext();
//     context->setContextProperty("apiClient", ApiClient::instance());
//     context->setContextProperty("ApiEndpoints", new ApiEndpoints());

//     ApiClient::instance()->loadToken();

//     const QUrl url(QStringLiteral("qrc:/new/prefix1/main.qml"));
//     QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                      &app, [url](QObject *obj, const QUrl &objUrl) {
//                          if (!obj && url == objUrl)
//                              QCoreApplication::exit(-1);
//                      }, Qt::QueuedConnection);
//     engine.load(url);

//     return app.exec();
// }
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QUrl>
#include <QSettings>

#include "apiclient.h"
#include "ApiEndPoints.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("apiClient", ApiClient::instance());
    context->setContextProperty("ApiEndpoints", new ApiEndpoints());

    ApiClient::instance()->loadToken();

    const QUrl url(QStringLiteral("qrc:/new/prefix1/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

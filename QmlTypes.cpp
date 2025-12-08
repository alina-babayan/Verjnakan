#include <QtQml>
#include <QQmlEngine>
#include <QJSEngine>

#include "apiclient.h"
#include "TokenStorage.h"

void registerQmlTypes()
{
    qmlRegisterSingletonType<ApiClient>("Lumin.Api", 1, 0, "ApiClient",[](QQmlEngine*, QJSEngine*) -> QObject*
                                        {
                                            auto *api = ApiClient::instance();
                                            QQmlEngine::setObjectOwnership(api, QQmlEngine::CppOwnership);
                                            return api;
                                        });

    qmlRegisterSingletonType<TokenStorage>("Lumin.Auth", 1, 0, "TokenStorage", [](QQmlEngine*, QJSEngine*) -> QObject*
                                           {
                                               auto *ts = TokenStorage::instance();
                                               QQmlEngine::setObjectOwnership(ts, QQmlEngine::CppOwnership);
                                               return ts;
                                           });
}

#include "TokenStorage.h"
#include <QSettings>

const QString TokenStorage::KEY_ACCESS  = "auth/accessToken";
const QString TokenStorage::KEY_REFRESH = "auth/refreshToken";

TokenStorage* TokenStorage::instance()
{
    static TokenStorage* s_instance = new TokenStorage;
    return s_instance;
}

TokenStorage::TokenStorage(QObject *parent) : QObject(parent) {}

// --- Getters ---
QString TokenStorage::accessToken() const
{
    return QSettings().value(KEY_ACCESS).toString();
}

QString TokenStorage::refreshToken() const
{
    return QSettings().value(KEY_REFRESH).toString();
}

// --- Setters ---
void TokenStorage::setAccessToken(const QString &token)
{
    QSettings s;
    s.setValue(KEY_ACCESS, token);
    emit tokensChanged();        // ← Now valid
}

void TokenStorage::setRefreshToken(const QString &token)
{
    QSettings s;
    s.setValue(KEY_REFRESH, token);
    emit tokensChanged();        // ← Now valid
}

// --- Public methods ---
void TokenStorage::saveTokens(const QString &access, const QString &refresh)
{
    QSettings s;
    s.setValue(KEY_ACCESS, access);
    if (!refresh.isEmpty())
        s.setValue(KEY_REFRESH, refresh);
    emit tokensChanged();        // ← Now valid
}

void TokenStorage::clear()
{
    QSettings s;
    s.remove(KEY_ACCESS);
    s.remove(KEY_REFRESH);
    emit tokensChanged();        // ← Now valid
}

#ifndef TOKENSTORAGE_H
#define TOKENSTORAGE_H
#include <QObject>
#include <QString>

class TokenStorage : public QObject
{
    Q_OBJECT                    // ← CRITICAL: MUST BE HERE

    Q_PROPERTY(QString accessToken READ accessToken WRITE setAccessToken NOTIFY tokensChanged)

public:
    static TokenStorage* instance();

    QString accessToken() const;
    void setAccessToken(const QString &token);

    QString refreshToken() const;
    void setRefreshToken(const QString &token);

    Q_INVOKABLE void saveTokens(const QString &access, const QString &refresh = "");
    Q_INVOKABLE void clear();

signals:
    void tokensChanged();    // ← Signal declared here

private:
    explicit TokenStorage(QObject *parent = nullptr);
    static const QString KEY_ACCESS;
    static const QString KEY_REFRESH;
};

#endif // TOKENSTORAGE_H

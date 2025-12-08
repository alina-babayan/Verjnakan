#ifndef APIENDPOINTS_H
#define APIENDPOINTS_H

#include <QString>
#include <QObject>

class ApiEndpoints : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString baseUrl READ baseUrl CONSTANT)
    Q_PROPERTY(QString login READ login CONSTANT)
    Q_PROPERTY(QString verifyLogin READ verifyLogin CONSTANT)
    Q_PROPERTY(QString registerInstructor READ registerInstructor CONSTANT)
    Q_PROPERTY(QString forgotPassword READ forgotPassword CONSTANT)
    Q_PROPERTY(QString resetPassword READ resetPassword CONSTANT)
    Q_PROPERTY(QString profile READ profile CONSTANT)
    Q_PROPERTY(QString changePassword READ changePassword CONSTANT)
    Q_PROPERTY(QString profileImage READ profileImage CONSTANT)
    Q_PROPERTY(QString removeProfileImage READ removeProfileImage CONSTANT)
    Q_PROPERTY(QString refresh READ refresh CONSTANT)
    Q_PROPERTY(QString notifications READ notifications CONSTANT)  // GET /api/notifications?limit=5
    Q_PROPERTY(QString readAllNotifications READ readAllNotifications CONSTANT)  // PUT /api/notifications/read-all

public:
    explicit ApiEndpoints(QObject *parent = nullptr);

    QString baseUrl() const { return m_baseUrl; }
    QString login() const { return m_baseUrl + "/api/auth/login"; }
    QString verifyLogin() const { return m_baseUrl + "/api/auth/verify-login"; }
    QString registerInstructor() const { return m_baseUrl + "/api/auth/register"; }
    QString forgotPassword() const { return m_baseUrl + "/api/auth/forgot-password"; }
    QString resetPassword() const { return m_baseUrl + "/api/auth/reset-password"; }
    QString profile() const { return m_baseUrl + "/api/user/profile"; }
    QString changePassword() const { return m_baseUrl + "/api/user/change-password"; }
    QString profileImage() const { return m_baseUrl + "/api/user/profile-image"; }
    QString removeProfileImage() const { return m_baseUrl + "/api/user/profile-image"; }
    QString refresh() const { return m_baseUrl + "/api/auth/refresh"; }
    QString notifications() const { return m_baseUrl + "/api/notifications"; }
    QString readAllNotifications() const { return m_baseUrl + "/api/notifications/read-all"; }

private:
    QString m_baseUrl = "https://learning-dashboard-rouge.vercel.app";
    Q_PROPERTY(QString search READ search CONSTANT)

    QString search() const { return m_baseUrl + "/api/search"; }
};

#endif // APIENDPOINTS_H

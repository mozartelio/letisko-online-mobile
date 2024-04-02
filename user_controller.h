#ifndef USERCONTROLLER_H
#define USERCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <qqml.h>

class UserController : public QObject
{
    Q_OBJECT
private:
    QNetworkAccessManager *manager;
    QTimer timer;
    QString jwtAuthorizationToken;

public:
    explicit UserController(QObject *parent = nullptr);
    Q_INVOKABLE void doLogin(const QString &email, const QString &password);
    Q_INVOKABLE bool doRegister(const QString &email, const QString &password);
signals:
    void loginResult(const QVariant& result);
};

#endif // USERCONTROLLER_H

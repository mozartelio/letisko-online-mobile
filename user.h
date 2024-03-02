#ifndef USER_H
#define USER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <qqml.h>

class User : public QObject
{
    Q_OBJECT
private:
    QNetworkAccessManager *manager;
    QTimer timer;


public:
    explicit User(QObject *parent = nullptr);
    Q_INVOKABLE bool doLogin(const QString& email, const QString& password);
    Q_INVOKABLE bool doRegister(const QString& email, const QString& password);
signals:
};

#endif // USER_H

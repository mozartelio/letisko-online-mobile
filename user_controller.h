#ifndef USERCONTROLLER_H
#define USERCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <qqml.h>
#include "flights_controller.h"

class UserController : public QObject
{
    Q_OBJECT
private:
    QNetworkAccessManager *m_networkManager;
    QTimer m_request_timer;
    QString m_jwtAuthorizationToken;
    FlightsController *m_flightsController;

    void setControllersParams();

public:
    explicit UserController(QObject *parent = nullptr);
    ~UserController();
    Q_INVOKABLE void doLogin(const QString &email, const QString &password);
    Q_INVOKABLE bool doRegister(const QString &email, const QString &password);
    Q_INVOKABLE FlightsController *getFlightsController() const;

    void setFlightsController(FlightsController *controller);

    // TODO: logout?
signals:
    void loginResult(const QVariant &result);

public slots:
    void handleLoginNetworkReply(QNetworkReply* reply);
};

#endif // USERCONTROLLER_H

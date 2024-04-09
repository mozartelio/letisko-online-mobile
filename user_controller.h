#ifndef USERCONTROLLER_H
#define USERCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <qqml.h>

#include "flights_controller.h"
#include "aircrafts_controller.h"
#include "user.h"

class UserController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(User *user READ getUser WRITE setUser NOTIFY userChanged)

public:
    explicit UserController(QObject *parent = nullptr);
    ~UserController();

    Q_INVOKABLE void doLogin(const QString &email, const QString &password);
    Q_INVOKABLE bool doRegister(const QString &email, const QString &password);

    Q_INVOKABLE FlightsController *getFlightsController() const;
    void setFlightsController(FlightsController *controller);

    Q_INVOKABLE AircraftsController *getAircraftsController() const;
    void setAircraftsController(AircraftsController *controller);

    User *getUser() const;
    void setUser(User *user);

public slots:
    void handleLoginNetworkReply(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_networkManager;
    QTimer m_requestTimer;
    QString m_jwtAuthorizationToken;
    FlightsController *m_flightsController;
    AircraftsController *m_aircraftsController;
    User *m_user;
    void performAfterAuthActions();

    // TODO: logout?
signals:
    void loginResult(const QVariant &result);
    void userChanged();
};

#endif // USERCONTROLLER_H

#ifndef USERCONTROLLER_H
#define USERCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <qqml.h>

#include "cpp/flight/flights_controller.h"
#include "cpp/aircraft/aircrafts_controller.h"
#include "cpp/user/user.h"

class UserController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(User *user READ getUser WRITE setUser NOTIFY userChanged)

public:
    explicit UserController(QObject *parent = nullptr);
    ~UserController();

    Q_INVOKABLE void doLogin(const QString &email, const QString &password);
    Q_INVOKABLE void doLogout();
    Q_INVOKABLE void doRegistration(const QString &email, const QString &password);
    Q_INVOKABLE void fillInProfileDetails(const QString &name, const QString &surname, const QString &street, const QString &buildingNumber, const QString &zipCode, const QString &city, const QString &state);
    void sendChangeRoleRequest();

    Q_INVOKABLE FlightsController *getFlightsController() const;
    void setFlightsController(FlightsController *controller);

    Q_INVOKABLE AircraftsController *getAircraftsController() const;
    void setAircraftsController(AircraftsController *controller);

    User *getUser() const;
    void setUser(User *user);

    Q_INVOKABLE bool isUserLoggedIn();

public slots:
    void handleLoginNetworkReply(QNetworkReply *reply);
    void handleRegistrationNetworkReply(QNetworkReply *reply, QString email, QString password);
    void handleProfileDetailsNetworkReply(QNetworkReply *reply);
    void handleChangeRoleReply(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_networkManager;
    QTimer m_requestTimer;
    QString m_jwtAuthorizationToken;
    FlightsController *m_flightsController;
    AircraftsController *m_aircraftsController;
    User *m_user;
    void performAfterAuthActions();

signals:
    void loginResult(const QVariant &result);
    void registrationResult(const QVariant &result);
    void profileDetailsFilledInResult(const QVariant &result);
    void changeRoleResult(const QVariant &result);
    void userChanged();
};

#endif // USERCONTROLLER_H

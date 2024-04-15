#ifndef AIRCRAFTSCONTROLLER_H
#define AIRCRAFTSCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QNetworkAccessManager>

#include "aircrafts_model.h"

class AircraftsController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoadingAircrafts READ isLoadingAircrafts WRITE setIsLoadingAircrafts NOTIFY isLoadingAircraftsChanged)
    Q_PROPERTY(bool isActiveScreen READ isActiveScreen WRITE setIsActiveScreen NOTIFY activeScreenChanged)

public:
    explicit AircraftsController(QNetworkAccessManager *networkManager);
    ~AircraftsController();

    void deleteFlightModel();

    QNetworkAccessManager *getNetworkManager() const;
    void setNetworkManager(QNetworkAccessManager *networkManager);

    QString getUserJwtAuthorizationToken() const;
    void setUserJwtAuthorizationToken(const QString &token);

    Q_INVOKABLE AircraftsModel *getAircraftsModel() const;
    void setAircraftsModel(AircraftsModel *model);

    Q_INVOKABLE void loadAircrafts();

    bool isLoadingAircrafts() const;
    void setIsLoadingAircrafts(bool isLoading);

    bool isActiveScreen() const;
    Q_INVOKABLE void setIsActiveScreen(bool isActive);

public slots:
    void handleAircraftsLoadNetworkReply(QNetworkReply *reply);
    void handleAircraftsUpdateNetworkReply(QNetworkReply *reply);

signals:
    void isLoadingAircraftsChanged();
    void activeScreenChanged();

private:
    QTimer m_requestTimer;
    QNetworkAccessManager *m_networkManager;
    QString m_userJwtAuthorizationToken;
    AircraftsModel *m_aircraftsModel;

    bool m_isLoadingAircrafts = false;
    bool m_isActiveScreen = false;

    void subscribeToAircraftsUpdates();
};

#endif // AIRCRAFTSCONTROLLER_H

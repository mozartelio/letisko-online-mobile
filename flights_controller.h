#ifndef FLIGHTSCONTROLLER_H
#define FLIGHTSCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QNetworkAccessManager>

#include "flights_model.h"

class FlightsController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoadingFlights READ isLoadingFlights WRITE setIsLoadingFlights NOTIFY loadingFlightsChanged)
    Q_PROPERTY(bool isActiveScreen READ isActiveScreen WRITE setIsActiveScreen NOTIFY activeScreenChanged)
public:
    explicit FlightsController(QNetworkAccessManager *networkManager);
    ~FlightsController();

    void deleteFlightModel();

    QNetworkAccessManager *getNetworkManager() const;
    void setNetworkManager(QNetworkAccessManager *networkManager);

    QString getUserJwtAuthorizationToken() const;
    void setUserJwtAuthorizationToken(const QString &token);

    Q_INVOKABLE FlightsModel *getFlightsModel() const;
    void setFlightsModel(FlightsModel *model);

    Q_INVOKABLE void loadFlights();

    bool isLoadingFlights() const;
    void setIsLoadingFlights(bool isLoading);

    bool isActiveScreen() const;
    Q_INVOKABLE void setIsActiveScreen(bool isActive);

public slots:
    void handleFlightsLoadNetworkReply(QNetworkReply *reply);
    void handleFlightsUpdateNetworkReply(QNetworkReply *reply);

signals:
    void loadingFlightsChanged();
    void activeScreenChanged();

private:
    QTimer m_requestTimer;
    QNetworkAccessManager *m_networkManager;
    QString m_userJwtAuthorizationToken;
    FlightsModel *m_flightsModel;

    bool m_isLoadingFlights = false;
    bool m_isActiveScreen = false;

    void subscribeToFlightsUpdates();
};
#endif // FLIGHTSCONTROLLER_H

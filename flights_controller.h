#ifndef FLIGHTSCONTROLLER_H
#define FLIGHTSCONTROLLER_H
#include <QTimer>
#include <QObject>
#include <QNetworkAccessManager>
#include "flights_model.h"

class FlightsController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoadingFlights READ isLoadingFlights WRITE setIsLoadingFlights NOTIFY isLoadingFlightsChanged)
private:
    QTimer m_loadFligthsTimer;
    QTimer m_request_timer;
    QNetworkAccessManager *m_networkManager;
    QString m_userJwtAuthorizationToken;
    FlightsModel *m_flightsModel;
    bool m_isLoadingFlights = false;

public:
    explicit FlightsController(QNetworkAccessManager *networkManager);
    ~FlightsController();

    void deleteFligthModel();

    QNetworkAccessManager *getNetworkManager() const;
    void setNetworkManager(QNetworkAccessManager *networkManager);

    QString getUserJwtAuthorizationToken() const;
    void setUserJwtAuthorizationToken(const QString &token);

    Q_INVOKABLE FlightsModel *getFlightsModel() const;
    void setFlightsModel(FlightsModel *model);

    Q_INVOKABLE void loadFlights();
    Q_INVOKABLE void loadFlightsOnTimer();
    Q_INVOKABLE void fligthScreenClosed();

    bool isLoadingFlights() const;
    void setIsLoadingFlights(bool isLoading);

public slots:
    void handleFligthsLoadNetworkReply(QNetworkReply *reply);

signals:
    void isLoadingFlightsChanged();
};
#endif // FLIGHTSCONTROLLER_H

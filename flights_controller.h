#ifndef FLIGHTSCONTROLLER_H
#define FLIGHTSCONTROLLER_H
#include <QTimer>
#include <QAbstractListModel>
#include <QNetworkAccessManager>
#include "filtering_roles.h"
#include "flights_filter_proxy_model.h"

class FlightInfo;

class FlightsController : public QAbstractListModel
{
    Q_OBJECT

private:
    QList<FlightInfo *> m_flightsList;
    QTimer m_loadFligthsTimer;
    QTimer m_request_timer;
    void init();
    QNetworkAccessManager *m_networkManager;
    QString m_userJwtAuthorizationToken;
    FlightsFilterProxyModel m_filterProxyModel;

public:
    explicit FlightsController(QNetworkAccessManager *networkManager);
    ~FlightsController();

    void addFlight(const QString &callsign, const QString &planeName, int flightStatus, const QDateTime &departureTime, const QDateTime &arrivalTime);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QNetworkAccessManager *getNetworkManager() const;
    void setNetworkManager(QNetworkAccessManager *networkManager);

    QString getUserJwtAuthorizationToken() const;
    void setUserJwtAuthorizationToken(const QString &token);

    // FlightsFilterProxyModel *getFilterProxyModel();
    FlightsFilterProxyModel *getFilterProxyModel();
    void setFilterProxyModel(const FlightsFilterProxyModel &filterProxyModel);

    Q_INVOKABLE void loadFlights();
    Q_INVOKABLE void loadFlightsOnTimer();
    Q_INVOKABLE void fligthScreenClosed();

public slots:
    void handleFligthsLoadNetworkReply(QNetworkReply *reply);


protected:
    QHash<int, QByteArray> roleNames() const override;
};
#endif // FLIGHTSCONTROLLER_H

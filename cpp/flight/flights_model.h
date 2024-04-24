#ifndef FLIGHTSMODEL_H
#define FLIGHTSMODEL_H

#include <QAbstractListModel>
#include <QDateTime>
#include <QString>
#include <QObject>

#include "flights_filter_proxy_model.h"
#include "flight_info.h"

class FlightsModel : public QAbstractListModel
{
private:
    QList<FlightInfo *> m_flightsList;
    FlightsFilterProxyModel *m_filterProxyModel;
    void init();

public:
    explicit FlightsModel();
    ~FlightsModel();

    void addFlight(const QString &callsign, const QString &departureAirport, const QString &arrivalAirport, FlightRequestStatus::Status flightStatus, const QDateTime &departureTime, const QDateTime &arrivalTime, unsigned int maxHeight, const QString &maxHeightMeasureUnits, const unsigned int fligthRequestId);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE FlightsFilterProxyModel *getFilterProxyModel() const;
    void setFilterProxyModel(FlightsFilterProxyModel *filterProxyModel);

    void removeAllFlights();
    bool removeFlight(int row);

protected:
    QHash<int, QByteArray> roleNames() const override;
};

#endif // FLIGHTSMODEL_H

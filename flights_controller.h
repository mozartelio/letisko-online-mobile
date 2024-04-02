#ifndef FLIGHTSCONTROLLER_H
#define FLIGHTSCONTROLLER_H
#include <QAbstractListModel>
#include "filtering_roles.h"
class FlightInfo;

class FlightsController : public QAbstractListModel
{
    Q_OBJECT
public:
    FlightsController();
    ~FlightsController();

    void addFlight(const QString &callsign, const QString &planeName, int flightStatus, const QDateTime &departureTime, const QDateTime &arrivalTime);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<FlightInfo *> m_flightsList;
};

#endif // FLIGHTSCONTROLLER_H

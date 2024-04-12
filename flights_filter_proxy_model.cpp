#include <QDateTime>
#include <QDebug>

#include "flights_filter_proxy_model.h"
#include "flights_roles.h"

FlightsFilterProxyModel::FlightsFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{

    //     qDebug() << "1 hello from after 00:00";
    //     setSortOrder(false);
    // }

    qDebug() << "hello from FlightsFilterProxyModel";
}

FlightsFilterProxyModel::~FlightsFilterProxyModel()
{
    qDebug() << "FlightsFilterProxyModel destructor";
}

bool FlightsFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    Q_UNUSED(sourceParent);

    // get the source model index for the current row
    QModelIndex sourceIndex = sourceModel()->index(sourceRow, 0);

    // get the data for each role and apply your filtering logic
    QVariant callsignData = sourceModel()->data(sourceIndex, FlightsRoles::CallsignRole);
    QVariant departureAirportData = sourceModel()->data(sourceIndex, FlightsRoles::DepartureAirportRole);
    QVariant arrivalAirportData = sourceModel()->data(sourceIndex, FlightsRoles::ArrivalAirportRole);
    QVariant flightStatusData = sourceModel()->data(sourceIndex, FlightsRoles::FlightStatusRole);
    QVariant departureTimeData = sourceModel()->data(sourceIndex, FlightsRoles::DepartureTimeRole);
    QVariant arrivalTimeData = sourceModel()->data(sourceIndex, FlightsRoles::ArrivalTimeRole);
    QVariant maxHeightData = sourceModel()->data(sourceIndex, FlightsRoles::MaxHeightRole);
    QVariant maxHeightMeasureUnitsData = sourceModel()->data(sourceIndex, FlightsRoles::MaxHeightMeasureUnitsRole);

    // applies filtering conditions here
    bool callsignMatches = callsignData.toString().contains(filterRegularExpression());
    bool departureAirportMatches = departureAirportData.toString().contains(filterRegularExpression());
    bool arrivalAirportMatches = arrivalAirportData.toString().contains(filterRegularExpression());
    bool flightStatusMatches = flightStatusData.toString().contains(filterRegularExpression());
    bool departureTimeMatches = departureTimeData.toDateTime().toString().contains(filterRegularExpression());
    bool arrivalTimeMatches = arrivalTimeData.toDateTime().toString().contains(filterRegularExpression());
    bool maxHeightMatches = maxHeightData.toString().contains(filterRegularExpression());
    bool maxHeightMeasureUnitsMatches = maxHeightMeasureUnitsData.toString().contains(filterRegularExpression());

    // returns true if any of the roles match the filter
    return callsignMatches || departureAirportMatches || arrivalAirportMatches || flightStatusMatches || departureTimeMatches || arrivalTimeMatches || maxHeightMatches || maxHeightMeasureUnitsMatches;
}

void FlightsFilterProxyModel::setFilterString(QString string)
{
    this->setFilterCaseSensitivity(Qt::CaseInsensitive);
    this->setFilterFixedString(string);
}

// TODO: Implement sorting
void FlightsFilterProxyModel::setSortOrder(bool checked)
{
    if (checked)
    {
        this->sort(4, Qt::DescendingOrder); // Sort by arrival time in descending order
        this->sort(5, Qt::DescendingOrder); // Sort by departure time in descending order
    }
    else
    {
        this->sort(4, Qt::AscendingOrder); // Sort by arrival time in ascending order
        this->sort(5, Qt::AscendingOrder); // Sort by departure time in ascending order
    }
}

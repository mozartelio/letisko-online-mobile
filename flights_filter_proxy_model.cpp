#include <QDateTime>
#include <QDebug>

#include "flights_filter_proxy_model.h"
#include "flights_roles.h"

FlightsFilterProxyModel::FlightsFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    this->setDynamicSortFilter(true);
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

bool FlightsFilterProxyModel::lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const
{
    QVariant leftData = sourceModel()->data(source_left, sortRole());
    QVariant rightData = sourceModel()->data(source_right, sortRole());

    if (sortRole() == FlightsRoles::DepartureTimeRole || sortRole() == FlightsRoles::ArrivalTimeRole)
    {
        QDateTime leftDate = QDateTime::fromString(leftData.toString(), Qt::ISODate);
        QDateTime rightDate = QDateTime::fromString(rightData.toString(), Qt::ISODate);
        return leftDate < rightDate;
    }
    else
    {
        return QSortFilterProxyModel::lessThan(source_left, source_right);
    }
}

void FlightsFilterProxyModel::setSortOrder(FlightsRoles::Roles role, bool ascending)
{
    if (role == FlightsRoles::DepartureTimeRole || role == FlightsRoles::ArrivalTimeRole)
    {
        Qt::SortOrder order = ascending ? Qt::AscendingOrder : Qt::DescendingOrder;
        this->setSortRole(role);
        this->sort(0, order);
    }
}
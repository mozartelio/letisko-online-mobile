#include <QDateTime>
#include <QDebug>
#include "flights_filter_proxy_model.h"

FlightsFilterProxyModel::FlightsFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{

//     qDebug() << "1 hello from after 00:00";
//     setSortOrder(false);
// }

// FlightsFilterProxyModel::FlightsFilterProxyModel()
//     : QSortFilterProxyModel()
// {

    qDebug() << "2 hello from after 00:00";


    // connect(sourceModel(), &QAbstractItemModel::dataChanged, this, &FlightsFilterProxyModel::dataChangedInSourceModel);
    // setSortOrder(false);
}



FlightsFilterProxyModel::~FlightsFilterProxyModel()
{
}

bool FlightsFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    Q_UNUSED(sourceParent);

    // get the source model index for the current row
    QModelIndex sourceIndex = sourceModel()->index(sourceRow, 0);

    // get the data for each role and apply your filtering logic
    QVariant callsignData = sourceModel()->data(sourceIndex, Roles::CallsignRole);
    QVariant planeNameData = sourceModel()->data(sourceIndex, Roles::PlaneNameRole);
    QVariant flightStatusData = sourceModel()->data(sourceIndex, Roles::FlightStatusRole);
    QVariant departureTimeData = sourceModel()->data(sourceIndex, Roles::DepartureTimeRole);
    QVariant arrivalTimeData = sourceModel()->data(sourceIndex, Roles::ArrivalTimeRole);

    // applies filtering conditions here
    bool callsignMatches = callsignData.toString().contains(filterRegularExpression());
    bool planeNameMatches = planeNameData.toString().contains(filterRegularExpression());
    bool flightStatusMatches = flightStatusData.toString().contains(filterRegularExpression());
    bool departureTimeMatches = departureTimeData.toDateTime().toString().contains(filterRegularExpression());
    bool arrivalTimeMatches = arrivalTimeData.toDateTime().toString().contains(filterRegularExpression());

    // returns true if any of the roles match the filter
    return callsignMatches || planeNameMatches || flightStatusMatches || departureTimeMatches || arrivalTimeMatches;
}

void FlightsFilterProxyModel::setFilterString(QString string)
{
    this->setFilterCaseSensitivity(Qt::CaseInsensitive);
    this->setFilterFixedString(string);
}

void FlightsFilterProxyModel::setSortOrder(bool checked)
{
    if (checked)
    {
        this->sort(0, Qt::DescendingOrder);
    }
    else
    {
        this->sort(0, Qt::AscendingOrder);
    }
}



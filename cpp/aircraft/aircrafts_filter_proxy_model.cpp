#include <QDateTime>
#include <QDebug>

#include "aircrafts_filter_proxy_model.h"
#include "aircrafts_roles.h"

AircraftsFilterProxyModel::AircraftsFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel{parent}
{
}

AircraftsFilterProxyModel::~AircraftsFilterProxyModel()
{
}

bool AircraftsFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    Q_UNUSED(sourceParent);

    // get the source model index for the current row
    QModelIndex sourceIndex = sourceModel()->index(sourceRow, 0);

    // get the data for each role and apply your filtering logic
    QVariant serialNumberData = sourceModel()->data(sourceIndex, AircraftsRoles::SerialNumberRole);
    QVariant totalTimeFlownData = sourceModel()->data(sourceIndex, AircraftsRoles::TotalTimeFlownRole);
    QVariant timeUnitNameData = sourceModel()->data(sourceIndex, AircraftsRoles::TimeUnitNameRole);
    QVariant registrationStateData = sourceModel()->data(sourceIndex, AircraftsRoles::RegistrationStateRole);
    QVariant aircraftTypeData = sourceModel()->data(sourceIndex, AircraftsRoles::AircraftTypeRole);
    QVariant flightRulesData = sourceModel()->data(sourceIndex, AircraftsRoles::FlightRulesRole);
    QVariant planeNameData = sourceModel()->data(sourceIndex, AircraftsRoles::PlaneNameRole);
    QVariant icaoWakeTurbulenceCategoryData = sourceModel()->data(sourceIndex, AircraftsRoles::IcaoWakeTurbulenceCategoryRole);

    // write for other roles #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT

    // applies filtering conditions here
    bool serialNumberMatches = serialNumberData.toString().contains(filterRegularExpression());
    bool totalTimeFlownMatches = totalTimeFlownData.toString().contains(filterRegularExpression());
    bool timeUnitNameMatches = timeUnitNameData.toString().contains(filterRegularExpression());
    bool registrationStateMatches = registrationStateData.toString().contains(filterRegularExpression());
    bool aircraftTypeMatches = aircraftTypeData.toString().contains(filterRegularExpression());
    bool flightRulesMatches = flightRulesData.toString().contains(filterRegularExpression());
    bool planeNameMatches = planeNameData.toString().contains(filterRegularExpression());
    bool icaoWakeTurbulenceCategoryMatches = icaoWakeTurbulenceCategoryData.toString().contains(filterRegularExpression());

    // returns true if any of the roles match the filter
    return serialNumberMatches || totalTimeFlownMatches || timeUnitNameMatches || registrationStateMatches ||
           aircraftTypeMatches || flightRulesMatches || planeNameMatches || icaoWakeTurbulenceCategoryMatches;
}

void AircraftsFilterProxyModel::setFilterString(QString string)
{
    this->setFilterCaseSensitivity(Qt::CaseInsensitive);
    this->setFilterFixedString(string);
}

// #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
void AircraftsFilterProxyModel::setSortOrder(bool checked)
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

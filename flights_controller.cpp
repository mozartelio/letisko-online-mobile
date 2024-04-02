#include "flights_controller.h"
#include "flight_info.h"

FlightsController::FlightsController()
{
}

FlightsController::~FlightsController()
{
}

int FlightsController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_flightsList.count();
}

QVariant FlightsController::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < rowCount())
    {

        FlightInfo *flightInfo = m_flightsList[index.row()];

        //        switch((Role) role) {
        switch (role)
        {
        case CallsignRole:
            return flightInfo->callsign();
        case PlaneNameRole:
            return flightInfo->planeName();
        case FlightStatusRole:
            return flightInfo->flightStatus();
        case DepartureTimeRole:
            return flightInfo->departureTime();
        case ArrivalTimeRole:
            return flightInfo->arrivalTime();
        }
    }
    return {};
}

void FlightsController::addFlight(const QString &callsign, const QString &planeName, int flightStatus, const QDateTime &departureTime, const QDateTime &arrivalTime)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    FlightInfo *newFlightInfo = new FlightInfo(this);
    newFlightInfo->setCallsign(callsign);
    newFlightInfo->setPlaneName(planeName);
    newFlightInfo->setFlightStatus(flightStatus);
    newFlightInfo->setDepartureTime(departureTime);
    newFlightInfo->setArrivalTime(arrivalTime);

    m_flightsList.append(newFlightInfo);
    endInsertRows();
}

QHash<int, QByteArray> FlightsController::roleNames() const
{
    QHash<int, QByteArray> filterRoles;
    filterRoles[CallsignRole] = "callsignData";
    filterRoles[PlaneNameRole] = "planeNameData";
    filterRoles[FlightStatusRole] = "flightStatusData";
    filterRoles[DepartureTimeRole] = "departureTimeData";
    filterRoles[ArrivalTimeRole] = "arrivalTimeData";

    // TODO: more filters

    return filterRoles;
}

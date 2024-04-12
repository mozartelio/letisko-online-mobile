#include <QObject>
#include <QDebug>
#include "flights_model.h"
#include "flights_roles.h"

FlightsModel::FlightsModel()
{
    qDebug() << "FlightsModel hello from";
    m_filterProxyModel = new FlightsFilterProxyModel();
    init();
}

FlightsModel::~FlightsModel()
{
    qDebug() << "FlightsModel destructor";
    removeAllFlights();
    delete m_filterProxyModel;
    m_filterProxyModel = nullptr;
}

void FlightsModel::init()
{
    m_filterProxyModel->setSourceModel(this);
    m_filterProxyModel->setFilterRole(CallsignRole);
    m_filterProxyModel->setFilterRole(DepartureAirportRole);
    m_filterProxyModel->setFilterRole(ArrivalAirportRole);
    m_filterProxyModel->setFilterRole(FlightStatusRole);
    m_filterProxyModel->setFilterRole(DepartureTimeRole);
    m_filterProxyModel->setFilterRole(ArrivalTimeRole);
    m_filterProxyModel->setFilterRole(MaxHeightRole);
    m_filterProxyModel->setFilterRole(MaxHeightMeasureUnitsRole);
}

void FlightsModel::removeAllFlights()
{
    for (int i = rowCount() - 1; i >= 0; i--)
    {
        removeFlight(i);
    }
}

bool FlightsModel::removeFlight(int row)
{
    if (row >= 0 && row < m_flightsList.count())
    {
        beginRemoveRows(QModelIndex(), row, row);

        FlightInfo *flightInfo = m_flightsList[row];
        delete flightInfo;
        flightInfo = nullptr;
        m_flightsList.removeAt(row);

        endRemoveRows();
        return true;
    }
    return false;
}

int FlightsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_flightsList.count();
}

QVariant FlightsModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < rowCount())
    {

        FlightInfo *flightInfo = m_flightsList[index.row()];

        //        switch((Role) role) {
        switch (role)
        {
        case CallsignRole:
            return flightInfo->getCallsign();
        case DepartureAirportRole:
            return flightInfo->getDepartureAirport();
        case ArrivalAirportRole:
            return flightInfo->getArrivalAirport();
        case FlightStatusRole:
            return flightInfo->getFlightStatus();
        case DepartureTimeRole:
            return flightInfo->getDepartureTime();
        case ArrivalTimeRole:
            return flightInfo->getArrivalTime();
        case MaxHeightRole:
            return flightInfo->getMaxHeight();
        case MaxHeightMeasureUnitsRole:
            return flightInfo->getMaxHeightMeasureUnits();
        }
    }
    return {};
}

void FlightsModel::addFlight(const QString &callsign, const QString &departureAirport, const QString &arrivalAirport, int flightStatus, const QDateTime &departureTime, const QDateTime &arrivalTime, unsigned int maxHeight, const QString &maxHeightMeasureUnits)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    FlightInfo *newFlightInfo = new FlightInfo(this);
    newFlightInfo->setCallsign(callsign);
    newFlightInfo->setDepartureAirport(departureAirport);
    newFlightInfo->setArrivalAirport(arrivalAirport);
    newFlightInfo->setFlightStatus(flightStatus);
    newFlightInfo->setDepartureTime(departureTime);
    newFlightInfo->setArrivalTime(arrivalTime);
    newFlightInfo->setMaxHeight(maxHeight);
    newFlightInfo->setMaxHeightMeasureUnits(maxHeightMeasureUnits);

    m_flightsList.append(newFlightInfo);
    endInsertRows();
}

QHash<int, QByteArray> FlightsModel::roleNames() const
{
    QHash<int, QByteArray> filterRoles;
    filterRoles[CallsignRole] = "callsignData";
    filterRoles[DepartureAirportRole] = "departureAirportData";
    filterRoles[ArrivalAirportRole] = "arrivalAirportData";
    filterRoles[FlightStatusRole] = "flightStatusData";
    filterRoles[DepartureTimeRole] = "departureTimeData";
    filterRoles[ArrivalTimeRole] = "arrivalTimeData";
    filterRoles[MaxHeightRole] = "maxHeightData";
    filterRoles[MaxHeightMeasureUnitsRole] = "maxHeightMeasureUnitsData";

    // TODO: more filters

    return filterRoles;
}

FlightsFilterProxyModel *FlightsModel::getFilterProxyModel() const
{
    return m_filterProxyModel;
}

void FlightsModel::setFilterProxyModel(FlightsFilterProxyModel *filterProxyModel)
{
    m_filterProxyModel = filterProxyModel;
}

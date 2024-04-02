#include "flight_info.h"

FlightInfo::FlightInfo(QObject *parent)
    : QObject{parent}
{
}


QString FlightInfo::callsign() const
{
    return m_callsign;
}

void FlightInfo::setCallsign(const QString& callsign)
{
    if (m_callsign != callsign) {
        m_callsign = callsign;
        emit callsignChanged();
    }
}

QString FlightInfo::planeName() const
{
    return m_planeName;
}

void FlightInfo::setPlaneName(const QString& planeName)
{
    if (m_planeName != planeName) {
        m_planeName = planeName;
        emit planeNameChanged();
    }
}

int FlightInfo::flightStatus() const
{
    return m_flightStatus;
}

void FlightInfo::setFlightStatus(int flightStatus)
{
    if (m_flightStatus != flightStatus) {
        m_flightStatus = flightStatus;
        emit flightStatusChanged();
    }
}

QDateTime FlightInfo::departureTime() const
{
    return m_departureTime;
}

void FlightInfo::setDepartureTime(const QDateTime& departureTime)
{
    if (m_departureTime != departureTime) {
        m_departureTime = departureTime;
        emit departureTimeChanged();
    }
}

QDateTime FlightInfo::arrivalTime() const
{
    return m_arrivalTime;
}

void FlightInfo::setArrivalTime(const QDateTime& arrivalTime)
{
    if (m_arrivalTime != arrivalTime) {
        m_arrivalTime = arrivalTime;
        emit arrivalTimeChanged();
    }
}

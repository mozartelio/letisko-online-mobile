#include "flight_info.h"

FlightInfo::FlightInfo(QObject *parent)
    : QObject{parent}
{
}

QString FlightInfo::getCallsign() const
{
    return m_callsign;
}

void FlightInfo::setCallsign(const QString &callsign)
{
    if (m_callsign != callsign)
    {
        m_callsign = callsign;
        emit callsignChanged();
    }
}

QString FlightInfo::getDepartureAirport() const
{
    return m_departureAirport;
}

void FlightInfo::setDepartureAirport(const QString &departureAirport)
{
    if (m_departureAirport != departureAirport)
    {
        m_departureAirport = departureAirport;
        emit departureAirportChanged();
    }
}

QString FlightInfo::getArrivalAirport() const
{
    return m_arrivalAirport;
}

void FlightInfo::setArrivalAirport(const QString &arrivalAirport)
{
    if (m_arrivalAirport != arrivalAirport)
    {
        m_arrivalAirport = arrivalAirport;
        emit arrivalAirportChanged();
    }
}

FlightRequestStatus::Status FlightInfo::getFlightStatus() const
{
    return m_flightStatus;
}

void FlightInfo::setFlightStatus(FlightRequestStatus::Status flightStatus)
{
    if (m_flightStatus != flightStatus)
    {
        m_flightStatus = flightStatus;
        emit flightStatusChanged();
    }
}

QDateTime FlightInfo::getDepartureTime() const
{
    return m_departureTime;
}

void FlightInfo::setDepartureTime(const QDateTime &departureTime)
{
    if (m_departureTime != departureTime)
    {
        m_departureTime = departureTime;
        emit departureTimeChanged();
    }
}

QDateTime FlightInfo::getArrivalTime() const
{
    return m_arrivalTime;
}

void FlightInfo::setArrivalTime(const QDateTime &arrivalTime)
{
    if (m_arrivalTime != arrivalTime)
    {
        m_arrivalTime = arrivalTime;
        emit arrivalTimeChanged();
    }
}

unsigned int FlightInfo::getMaxHeight() const
{
    return m_maxHeight;
}

void FlightInfo::setMaxHeight(unsigned int maxHeight)
{
    if (m_maxHeight != maxHeight)
    {
        m_maxHeight = maxHeight;
        emit maxHeightChanged();
    }
}

QString FlightInfo::getMaxHeightMeasureUnits() const
{
    return m_maxHeightMeasureUnits;
}

void FlightInfo::setMaxHeightMeasureUnits(const QString &maxHeightMeasureUnits)
{
    if (m_maxHeightMeasureUnits != maxHeightMeasureUnits)
    {
        m_maxHeightMeasureUnits = maxHeightMeasureUnits;
        emit maxHeightMeasureUnitsChanged();
    }
}

unsigned int FlightInfo::getFlightRequestId() const
{
    return m_flightRequestId;
}

void FlightInfo::setFlightRequestId(const unsigned int flightRequestId)
{
    if (m_flightRequestId != flightRequestId)
    {
        m_flightRequestId = flightRequestId;
        emit flightRequestIdChanged();
    }
}

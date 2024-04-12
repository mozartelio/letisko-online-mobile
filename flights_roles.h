#ifndef FLIGHTS_ROLES_H
#define FLIGHTS_ROLES_H
#include <QAbstractListModel>

enum FlightsRoles
{
    CallsignRole = Qt::UserRole + 1,
    FlightStatusRole = Qt::UserRole + 2,
    DepartureTimeRole = Qt::UserRole + 3,
    ArrivalTimeRole = Qt::UserRole + 4,
    DepartureAirportRole = Qt::UserRole + 5,
    ArrivalAirportRole = Qt::UserRole + 6,
    MaxHeightRole = Qt::UserRole + 7,
    MaxHeightMeasureUnitsRole = Qt::UserRole + 8
};
#endif // FLIGHTS_ROLES_H

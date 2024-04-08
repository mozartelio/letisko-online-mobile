#ifndef FLIGHTS_ROLES_H
#define FLIGHTS_ROLES_H
#include <QAbstractListModel>

enum FlightsRoles
{
    CallsignRole = Qt::UserRole + 1,
    PlaneNameRole = Qt::UserRole + 2,
    FlightStatusRole = Qt::UserRole + 3,
    DepartureTimeRole = Qt::UserRole + 4,
    ArrivalTimeRole = Qt::UserRole + 5
};
#endif // FLIGHTS_ROLES_H

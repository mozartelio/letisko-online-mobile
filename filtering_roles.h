#ifndef FILTERING_ROLES_H
#define FILTERING_ROLES_H
#include <QAbstractListModel>

enum Roles
{
    CallsignRole = Qt::UserRole + 1,
    PlaneNameRole = Qt::UserRole + 2,
    FlightStatusRole = Qt::UserRole + 3,
    DepartureTimeRole = Qt::UserRole + 4,
    ArrivalTimeRole = Qt::UserRole + 5
};
#endif // FILTERING_ROLES_H

#ifndef AIRCRAFTS_ROLES_H
#define AIRCRAFTS_ROLES_H

#include <QAbstractListModel>

enum AircraftsRoles
{
    SerialNumberRole = Qt::UserRole + 1,
    TotalTimeFlownRole = Qt::UserRole + 2,
    TimeUnitNameRole = Qt::UserRole + 3,
    RegistrationStateRole = Qt::UserRole + 4,
    AircraftTypeRole = Qt::UserRole + 5,
    FlightRulesRole = Qt::UserRole + 6,
    PlaneNameRole = Qt::UserRole + 7,
    IcaoWakeTurbulenceCategoryRole = Qt::UserRole + 8,

    OwnerName = Qt::UserRole + 9,
    AircraftCategory = Qt::UserRole + 10,
    AircraftClass = Qt::UserRole + 11,
    LastMaintainance = Qt::UserRole + 12,
    ImagePath = Qt::UserRole + 13
};

#endif // AIRCRAFTS_ROLES_H

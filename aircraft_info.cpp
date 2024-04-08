#include "aircraft_info.h"

AircraftInfo::AircraftInfo(QObject *parent)
    : QObject{parent}
{}

QString AircraftInfo::getSerialNumber() const
{
    return m_serialNumber;
}

void AircraftInfo::setSerialNumber(const QString &serialNumber)
{
    m_serialNumber = serialNumber;
    emit serialNumberChanged();
}

double AircraftInfo::getTotalTimeFlown() const
{
    return m_totalTimeFlown;
}

void AircraftInfo::setTotalTimeFlown(double totalTimeFlown)
{
    m_totalTimeFlown = totalTimeFlown;
    emit totalTimeFlownChanged();
}

QString AircraftInfo::getTimeUnitName() const
{
    return m_timeUnitName;
}

void AircraftInfo::setTimeUnitName(const QString &timeUnitName)
{
    m_timeUnitName = timeUnitName;
    emit timeUnitNameChanged();
}

QString AircraftInfo::getRegistrationState() const
{
    return m_registrationState;
}

void AircraftInfo::setRegistrationState(const QString &registrationState)
{
    m_registrationState = registrationState;
    emit registrationStateChanged();
}

QString AircraftInfo::getAircraftType() const
{
    return m_aircraftType;
}

void AircraftInfo::setAircraftType(const QString &aircraftType)
{
    m_aircraftType = aircraftType;
    emit aircraftTypeChanged();
}

QString AircraftInfo::getFlightRules() const
{
    return m_flightRules;
}

void AircraftInfo::setFlightRules(const QString &flightRules)
{
    m_flightRules = flightRules;
    emit flightRulesChanged();
}

QString AircraftInfo::getPlaneName() const
{
    return m_planeName;
}

void AircraftInfo::setPlaneName(const QString &planeName)
{
    m_planeName = planeName;
    emit planeNameChanged();
}

QString AircraftInfo::getIcaoWakeTurbulenceCategory() const
{
    return m_icaoWakeTurbulenceCategory;
}

void AircraftInfo::setIcaoWakeTurbulenceCategory(const QString &icaoWakeTurbulenceCategory)
{
    m_icaoWakeTurbulenceCategory = icaoWakeTurbulenceCategory;
    emit icaoWakeTurbulenceCategoryChanged();
}

QString AircraftInfo::getOwnerName() const
{
    return m_ownerName;
}

void AircraftInfo::setOwnerName(const QString &ownerName)
{
    m_ownerName = ownerName;
    emit ownerNameChanged();
}

QString AircraftInfo::getAircraftCategory() const
{
    return m_aircraftCategory;
}

void AircraftInfo::setAircraftCategory(const QString &aircraftCategory)
{
    m_aircraftCategory = aircraftCategory;
    emit aircraftCategoryChanged();
}

QString AircraftInfo::getAircraftClass() const
{
    return m_aircraftClass;
}

void AircraftInfo::setAircraftClass(const QString &aircraftClass)
{
    m_aircraftClass = aircraftClass;
    emit aircraftClassChanged();
}

QDate AircraftInfo::getLastMaintainance() const
{
    return m_lastMaintainance;
}

void AircraftInfo::setLastMaintainance(const QDate &lastMaintenance)
{
    m_lastMaintainance = lastMaintenance;
    emit lastMaintainanceChanged();
}

QUrl AircraftInfo::getImagePath() const
{
    return m_imagePath;
}

void AircraftInfo::setImagePath(const QUrl &imagePath)
{
    m_imagePath = imagePath;
    emit imagePathChanged();
}


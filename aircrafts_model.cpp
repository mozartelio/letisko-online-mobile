#include <QDebug>


#include "aircrafts_model.h"
#include "aircrafts_roles.h"


AircraftsModel::AircraftsModel()
{
    qDebug() << "AircraftsModel hello from";
    m_filterProxyModel = new AircraftsFilterProxyModel();
    init();
}

AircraftsModel::~AircraftsModel()
{
    qDebug() << "AircraftsModel destructor";
    removeAllFlights();
    delete m_filterProxyModel;
    m_filterProxyModel = nullptr;
}

void AircraftsModel::init()
{
    m_filterProxyModel->setSourceModel(this);
    m_filterProxyModel->setFilterRole(SerialNumberRole);
    m_filterProxyModel->setFilterRole(TotalTimeFlownRole);
    m_filterProxyModel->setFilterRole(TimeUnitNameRole);
    m_filterProxyModel->setFilterRole(RegistrationStateRole);
    m_filterProxyModel->setFilterRole(AircraftTypeRole);
    m_filterProxyModel->setFilterRole(FlightRulesRole);
    m_filterProxyModel->setFilterRole(PlaneNameRole);
    m_filterProxyModel->setFilterRole(IcaoWakeTurbulenceCategoryRole);
}

void AircraftsModel::removeAllFlights()
{
    for (int i = rowCount() - 1; i >= 0; i--)
    {
        removeFlight(i);
    }
}

bool AircraftsModel::removeFlight(int row)
{
    if (row >= 0 && row < m_aircraftsList.count())
    {
        beginRemoveRows(QModelIndex(), row, row);

        AircraftInfo *AircraftInfo = m_aircraftsList[row];
        delete AircraftInfo;
        AircraftInfo = nullptr;
        m_aircraftsList.removeAt(row);

        endRemoveRows();
        return true;
    }
    return false;
}

int AircraftsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_aircraftsList.count();
}

QVariant AircraftsModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < rowCount())
    {
        AircraftInfo *aircraftInfo = m_aircraftsList[index.row()];

        switch (role)
        {
        case SerialNumberRole:
            return aircraftInfo->getSerialNumber();
        case TotalTimeFlownRole:
            return aircraftInfo->getTotalTimeFlown();
        case TimeUnitNameRole:
            return aircraftInfo->getTimeUnitName();
        case RegistrationStateRole:
            return aircraftInfo->getRegistrationState();
        case AircraftTypeRole:
            return aircraftInfo->getAircraftType();
        case FlightRulesRole:
            return aircraftInfo->getFlightRules();
        case PlaneNameRole:
            return aircraftInfo->getPlaneName();
        case IcaoWakeTurbulenceCategoryRole:
            return aircraftInfo->getIcaoWakeTurbulenceCategory();
        case OwnerName:
            return aircraftInfo->getOwnerName();
        case AircraftCategory:
            return aircraftInfo->getAircraftCategory();
        case AircraftClass:
            return aircraftInfo->getAircraftClass();
        case LastMaintainance:
            return aircraftInfo->getLastMaintainance();
        case ImagePath:
            return aircraftInfo->getImagePath();
        }
    }
    return {};
}

void AircraftsModel::addAircraft(const QString &serialNumber, const double &totalTimeFlown, const QString &timeUnitName, const QString &registrationState, const QString &aircraftType, const QString &flightRules, const QString &planeName, const QString &icaoWakeTurbulenceCategory, const QString &ownerName, const QString &aircraftCategory, const QString &aircraftClass, const QDate &lastMaintainance, const QUrl &imagePath)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    AircraftInfo *newAircraftInfo = new AircraftInfo(this);
    newAircraftInfo->setSerialNumber(serialNumber);
    newAircraftInfo->setTotalTimeFlown(totalTimeFlown);
    newAircraftInfo->setTimeUnitName(timeUnitName);
    newAircraftInfo->setRegistrationState(registrationState);
    newAircraftInfo->setAircraftType(aircraftType);
    newAircraftInfo->setFlightRules(flightRules);
    newAircraftInfo->setPlaneName(planeName);
    newAircraftInfo->setIcaoWakeTurbulenceCategory(icaoWakeTurbulenceCategory);
    newAircraftInfo->setOwnerName(ownerName);
    newAircraftInfo->setAircraftCategory(aircraftCategory);
    newAircraftInfo->setAircraftClass(aircraftClass);
    newAircraftInfo->setLastMaintainance(lastMaintainance);
    newAircraftInfo->setImagePath(imagePath);

    m_aircraftsList.append(newAircraftInfo);
    endInsertRows();
}

QHash<int, QByteArray> AircraftsModel::roleNames() const
{
    QHash<int, QByteArray> filterRoles;
    filterRoles[SerialNumberRole] = "serialNumberData";
    filterRoles[TotalTimeFlownRole] = "totalTimeFlownData";
    filterRoles[TimeUnitNameRole] = "timeUnitNameData";
    filterRoles[RegistrationStateRole] = "registrationStateData";
    filterRoles[AircraftTypeRole] = "aircraftTypeData";
    filterRoles[FlightRulesRole] = "flightRulesData";
    filterRoles[PlaneNameRole] = "planeNameData";
    filterRoles[IcaoWakeTurbulenceCategoryRole] = "icaoWakeTurbulenceCategoryData";

    filterRoles[OwnerName] = "ownerNameData";
    filterRoles[AircraftCategory] = "aircraftCategoryData";
    filterRoles[AircraftClass] = "aircraftClassData";
    filterRoles[LastMaintainance] = "lastMaintainanceData";
    filterRoles[ImagePath] = "imagePathData";
    return filterRoles;
}

AircraftsFilterProxyModel *AircraftsModel::getFilterProxyModel() const
{
    return m_filterProxyModel;
}

void AircraftsModel::setFilterProxyModel(AircraftsFilterProxyModel *filterProxyModel)
{
    m_filterProxyModel = filterProxyModel;
}

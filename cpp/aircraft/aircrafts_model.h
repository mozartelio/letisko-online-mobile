#ifndef AIRCRAFTSMODEL_H
#define AIRCRAFTSMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QModelIndex>
#include <QByteArray>
#include <QHash>
#include <QVariant>

#include "aircraft_info.h"
#include "aircrafts_filter_proxy_model.h"

class AircraftsModel : public QAbstractListModel
{
private:
    QList<AircraftInfo *> m_aircraftsList;
    AircraftsFilterProxyModel *m_filterProxyModel;
    void init();

public:
    explicit AircraftsModel();
    ~AircraftsModel();
    
    void addAircraft(const QString &serialNumber, const double &totalTimeFlown, const QString &timeUnitName, const QString &registrationState, const QString &aircraftType, const QString &flightRules, const QString &planeName, const QString &icaoWakeTurbulenceCategory, const QString &ownerName, const QString &aircraftCategory, const QString &aircraftClass, const QDate &lastMaintainance, const QUrl &imagePath);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE AircraftsFilterProxyModel *getFilterProxyModel() const;
    void setFilterProxyModel(AircraftsFilterProxyModel *filterProxyModel);

    void removeAllFlights();
    bool removeFlight(int row);

protected:
    QHash<int, QByteArray> roleNames() const override;
};

#endif // AIRCRAFTSMODEL_H

#ifndef AIRCRAFTINFO_H
#define AIRCRAFTINFO_H

#include <QObject>
#include <QString>
#include <QDate>
#include <QUrl>

class AircraftInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getSerialNumber READ getSerialNumber WRITE setSerialNumber NOTIFY serialNumberChanged REQUIRED)
    Q_PROPERTY(double getTotalTimeFlown READ getTotalTimeFlown WRITE setTotalTimeFlown NOTIFY totalTimeFlownChanged REQUIRED)
    Q_PROPERTY(QString getTimeUnitName READ getTimeUnitName WRITE setTimeUnitName NOTIFY timeUnitNameChanged REQUIRED)
    Q_PROPERTY(QString getRegistrationState READ getRegistrationState WRITE setRegistrationState NOTIFY registrationStateChanged REQUIRED)
    Q_PROPERTY(QString getAircraftType READ getAircraftType WRITE setAircraftType NOTIFY aircraftTypeChanged REQUIRED)
    Q_PROPERTY(QString getFlightRules READ getFlightRules WRITE setFlightRules NOTIFY flightRulesChanged REQUIRED)
    Q_PROPERTY(QString getPlaneName READ getPlaneName WRITE setPlaneName NOTIFY planeNameChanged REQUIRED)
    Q_PROPERTY(QString getIcaoWakeTurbulenceCategory READ getIcaoWakeTurbulenceCategory WRITE setIcaoWakeTurbulenceCategory NOTIFY icaoWakeTurbulenceCategoryChanged REQUIRED)

    Q_PROPERTY(QString getOwnerName READ getOwnerName WRITE setOwnerName NOTIFY ownerNameChanged)
    Q_PROPERTY(QString getAircraftCategory READ getAircraftCategory WRITE setAircraftCategory NOTIFY aircraftCategoryChanged)
    Q_PROPERTY(QString getAircraftClass READ getAircraftClass WRITE setAircraftClass NOTIFY aircraftClassChanged)
    Q_PROPERTY(QDate getLastMaintainance READ getLastMaintainance WRITE setLastMaintainance NOTIFY lastMaintainanceChanged)
    Q_PROPERTY(QUrl getImagePath READ getImagePath WRITE setImagePath NOTIFY imagePathChanged)

public:
    explicit AircraftInfo(QObject *parent = nullptr);

    QString getSerialNumber() const;
    void setSerialNumber(const QString &serialNumber);
    double getTotalTimeFlown() const;
    void setTotalTimeFlown(double totalTimeFlown);
    QString getTimeUnitName() const;
    void setTimeUnitName(const QString &timeUnitName);
    QString getRegistrationState() const;
    void setRegistrationState(const QString &registrationState);
    QString getAircraftType() const;
    void setAircraftType(const QString &aircraftType);
    QString getFlightRules() const;
    void setFlightRules(const QString &flightRules);
    QString getPlaneName() const;
    void setPlaneName(const QString &planeName);
    QString getIcaoWakeTurbulenceCategory() const;
    void setIcaoWakeTurbulenceCategory(const QString &icaoWakeTurbulenceCategory);

    QString getOwnerName() const;
    void setOwnerName(const QString &ownerName);
    QString getAircraftCategory() const;
    void setAircraftCategory(const QString &aircraftCategory);
    QString getAircraftClass() const;
    void setAircraftClass(const QString &aircraftClass);
    QDate getLastMaintainance() const;
    void setLastMaintainance(const QDate &lastMaintainance);
    QUrl getImagePath() const;
    void setImagePath(const QUrl &imagePath);

signals:
    void serialNumberChanged();
    void totalTimeFlownChanged();
    void timeUnitNameChanged();
    void registrationStateChanged();
    void aircraftTypeChanged();
    void flightRulesChanged();
    void planeNameChanged();
    void icaoWakeTurbulenceCategoryChanged();

    void ownerNameChanged();
    void aircraftCategoryChanged();
    void aircraftClassChanged();
    void lastMaintainanceChanged();
    void imagePathChanged();

private:
    QString m_serialNumber;
    double m_totalTimeFlown;
    QString m_timeUnitName;
    QString m_registrationState;
    QString m_aircraftType;
    QString m_flightRules;
    QString m_planeName;
    QString m_icaoWakeTurbulenceCategory;

    QString m_ownerName;
    QString m_aircraftCategory;
    QString m_aircraftClass;
    QDate m_lastMaintainance;
    QUrl m_imagePath;
};

#endif // AIRCRAFTINFO_H

#ifndef ADDRESS_H
#define ADDRESS_H

#include <QObject>
#include <QString>

class Address : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString buildingNumber READ getBuildingNumber WRITE setBuildingNumber NOTIFY buildingNumberChanged REQUIRED)
    Q_PROPERTY(QString city READ getCity WRITE setCity NOTIFY cityChanged REQUIRED)
    Q_PROPERTY(QString state READ getState WRITE setState NOTIFY stateChanged REQUIRED)
    Q_PROPERTY(QString street READ getStreet WRITE setStreet NOTIFY streetChanged REQUIRED)
    Q_PROPERTY(QString zipCode READ getZipCode WRITE setZipCode NOTIFY zipCodeChanged REQUIRED)

public:
    explicit Address(QObject *parent = nullptr);

    explicit Address(const QString &buildingNumber, const QString &city, const QString &street, const QString &state, const QString &zipCode);

    ~Address();

    QString getBuildingNumber() const;
    void setBuildingNumber(const QString &buildingNumber);

    QString getCity() const;
    void setCity(const QString &city);

    QString getState() const;
    void setState(const QString &state);

    QString getStreet() const;
    void setStreet(const QString &street);

    QString getZipCode() const;
    void setZipCode(const QString &zipCode);

signals:
    void buildingNumberChanged(const QString &newBuildingNumber);
    void cityChanged(const QString &newCity);
    void stateChanged(const QString &newState);
    void streetChanged(const QString &newStreet);
    void zipCodeChanged(const QString &newZipCode);

private:
    QString m_buildingNumber;
    QString m_city;
    QString m_state;
    QString m_street;
    QString m_zipCode;
};

#endif // ADDRESS_H

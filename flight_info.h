#ifndef FLIGHTINFO_H
#define FLIGHTINFO_H

#include <QObject>
#include <QDateTime>

class FlightInfo : public QObject
{
    Q_OBJECT
        // QML_ELEMENT

    Q_PROPERTY(QString callsign READ callsign WRITE setCallsign NOTIFY callsignChanged REQUIRED)
    Q_PROPERTY(QString planeName READ planeName WRITE setPlaneName NOTIFY planeNameChanged REQUIRED)
    Q_PROPERTY(int flightStatus READ flightStatus WRITE setFlightStatus NOTIFY flightStatusChanged REQUIRED)
    Q_PROPERTY(QDateTime departureTime READ departureTime WRITE setDepartureTime NOTIFY departureTimeChanged REQUIRED)
    Q_PROPERTY(QDateTime arrivalTime READ arrivalTime WRITE setArrivalTime NOTIFY arrivalTimeChanged REQUIRED)

public:
    explicit FlightInfo(QObject *parent = nullptr);
    // ~FlightInfo();

    QString callsign() const;
    void setCallsign(const QString &callsign);

    QString planeName() const;
    void setPlaneName(const QString &planeName);

    int flightStatus() const;
    void setFlightStatus(int flightStatus);

    QDateTime departureTime() const;
    void setDepartureTime(const QDateTime &departureTime);

    QDateTime arrivalTime() const;
    void setArrivalTime(const QDateTime &arrivalTime);

signals:
    void callsignChanged();
    void planeNameChanged();
    void flightStatusChanged();
    void departureTimeChanged();
    void arrivalTimeChanged();

private:
    QString m_callsign;
    QString m_planeName;
    int m_flightStatus;
    QDateTime m_departureTime;
    QDateTime m_arrivalTime;
};
#endif // FLIGHTINFO_H

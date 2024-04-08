#ifndef FLIGHTINFO_H
#define FLIGHTINFO_H

#include <QObject>
#include <QDateTime>

class FlightInfo : public QObject
{
    Q_OBJECT
        // QML_ELEMENT

    Q_PROPERTY(QString callsign READ getCallsign WRITE setCallsign NOTIFY callsignChanged REQUIRED)
    Q_PROPERTY(QString planeName READ getPlaneName WRITE setPlaneName NOTIFY planeNameChanged REQUIRED)
    Q_PROPERTY(int flightStatus READ getFlightStatus WRITE setFlightStatus NOTIFY flightStatusChanged REQUIRED)
    Q_PROPERTY(QDateTime departureTime READ getDepartureTime WRITE setDepartureTime NOTIFY departureTimeChanged REQUIRED)
    Q_PROPERTY(QDateTime getArrivalTime READ getArrivalTime WRITE setArrivalTime NOTIFY arrivalTimeChanged REQUIRED)

public:
    explicit FlightInfo(QObject *parent = nullptr);
    // ~FlightInfo();

    QString getCallsign() const;
    void setCallsign(const QString &callsign);

    QString getPlaneName() const;
    void setPlaneName(const QString &planeName);

    int getFlightStatus() const;
    void setFlightStatus(int flightStatus);

    QDateTime getDepartureTime() const;
    void setDepartureTime(const QDateTime &departureTime);

    QDateTime getArrivalTime() const;
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

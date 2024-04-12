#ifndef FLIGHTINFO_H
#define FLIGHTINFO_H

#include <QObject>
#include <QDateTime>

class FlightInfo : public QObject
{
    Q_OBJECT
    // QML_ELEMENT

    Q_PROPERTY(QString callsign READ getCallsign WRITE setCallsign NOTIFY callsignChanged REQUIRED)
    Q_PROPERTY(QString departureAirport READ getDepartureAirport WRITE setDepartureAirport NOTIFY departureAirportChanged REQUIRED)
    Q_PROPERTY(QString arrivalAirport READ getArrivalAirport WRITE setArrivalAirport NOTIFY arrivalAirportChanged REQUIRED)
    Q_PROPERTY(int flightStatus READ getFlightStatus WRITE setFlightStatus NOTIFY flightStatusChanged REQUIRED)
    Q_PROPERTY(QDateTime departureTime READ getDepartureTime WRITE setDepartureTime NOTIFY departureTimeChanged REQUIRED)
    Q_PROPERTY(QDateTime getArrivalTime READ getArrivalTime WRITE setArrivalTime NOTIFY arrivalTimeChanged REQUIRED)
    Q_PROPERTY(unsigned int maxHeight READ getMaxHeight WRITE setMaxHeight NOTIFY maxHeightChanged REQUIRED)
    Q_PROPERTY(QString maxHeightMeasureUnits READ getMaxHeightMeasureUnits WRITE setMaxHeightMeasureUnits NOTIFY maxHeightMeasureUnitsChanged REQUIRED)

public:
    explicit FlightInfo(QObject *parent = nullptr);
    // ~FlightInfo();

    QString getCallsign() const;
    void setCallsign(const QString &callsign);

    QString getDepartureAirport() const;
    void setDepartureAirport(const QString &departueAirport);

    QString getArrivalAirport() const;
    void setArrivalAirport(const QString &arrivalAirport);

    int getFlightStatus() const;
    void setFlightStatus(int flightStatus);

    QDateTime getDepartureTime() const;
    void setDepartureTime(const QDateTime &departureTime);

    QDateTime getArrivalTime() const;
    void setArrivalTime(const QDateTime &arrivalTime);

    unsigned int getMaxHeight() const;
    void setMaxHeight(unsigned maxHeight);

    QString getMaxHeightMeasureUnits() const;
    void setMaxHeightMeasureUnits(const QString &maxHeightMeasureUnits);

signals:
    void callsignChanged();
    void departureAirportChanged();
    void arrivalAirportChanged();
    void flightStatusChanged();
    void departureTimeChanged();
    void arrivalTimeChanged();
    void maxHeightChanged();
    void maxHeightMeasureUnitsChanged();

private:
    QString m_callsign;
    QString m_departureAirport;
    QString m_arrivalAirport;
    int m_flightStatus;
    QDateTime m_departureTime;
    QDateTime m_arrivalTime;
    unsigned int m_maxHeight;
    QString m_maxHeightMeasureUnits;
};
#endif // FLIGHTINFO_H

#ifndef FLIGHT_REQUEST_STATUS_H
#define FLIGHT_REQUEST_STATUS_H
#include <QObject>
#include <QObject>
#include <QVariant>

class FlightRequestStatus : public QObject
{
    Q_OBJECT
    Q_ENUMS(Status)

public:
    static FlightRequestStatus *instance();


    enum Status
    {
        Denied,
        Approved,
        Pending,
        Undefined
    };
    Q_ENUM(Status)

    Q_INVOKABLE QString statusToString(Status status);
    Q_INVOKABLE Status stringToStatus(const QString &str);

private:
    FlightRequestStatus(QObject *parent = nullptr) : QObject(parent) {};

    ~FlightRequestStatus();

    static FlightRequestStatus *m_instance;

};
#endif // FLIGHT_REQUEST_STATUS_H

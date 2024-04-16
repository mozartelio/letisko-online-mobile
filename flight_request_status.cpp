#include <QObject>
#include <map>
#include <string>
#include <algorithm>

#include "flight_request_status.h"


FlightRequestStatus *FlightRequestStatus::m_instance = nullptr;

FlightRequestStatus *FlightRequestStatus::instance()
{
    if (m_instance == nullptr)
    {
        m_instance = new FlightRequestStatus();
        qDebug() << "FlightRequestStatus::instance():";
    }

    return m_instance;
}

FlightRequestStatus::~FlightRequestStatus()
{
    delete m_instance;
    m_instance = nullptr;
}

QString FlightRequestStatus::statusToString(Status status)
{
    std::map<Status, std::string> map = {
        {Denied, "denied"},
        {Approved, "approved"},
        {Pending, "pending"},
        {Undefined, "undefined"}
    };

    auto it = map.find(status);
    if (it != map.end()) {
        return QString::fromStdString(it->second);
    } else {
        return QString("undefined");
    }
}

FlightRequestStatus::Status FlightRequestStatus::stringToStatus(const QString &str)
{
    std::map<std::string, Status> map = {
        {"denied", Denied},
        {"approved", Approved},
        {"pending", Pending},
        {"undefined", Undefined}
    };

    std::string lowerStr = str.toLower().toStdString();
    auto it = map.find(lowerStr);
    if (it != map.end()) {
        return it->second;
    } else {
        return Undefined;
    }
}

#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include "flights_controller.h"
#include "flight_info.h"
#include "request_constants.h"

FlightsController::FlightsController(QNetworkAccessManager *networkManager)
{
    qDebug() << "FlightsController hello from after 00:00";
    setNetworkManager(networkManager);
    connect(&m_loadFligthsTimer, &QTimer::timeout, this, &FlightsController::loadFlights);
    init();
}

void FlightsController::init()
{
    // m_filterProxyModel(this);
    m_filterProxyModel.setSourceModel(this);
    m_filterProxyModel.setFilterRole(CallsignRole);
    m_filterProxyModel.setFilterRole(PlaneNameRole);
    m_filterProxyModel.setFilterRole(FlightStatusRole);
    m_filterProxyModel.setFilterRole(DepartureTimeRole);
    m_filterProxyModel.setFilterRole(ArrivalTimeRole);
    m_filterProxyModel.setSortRole(CallsignRole);
}

FlightsController::~FlightsController()
{
}

int FlightsController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_flightsList.count();
}

QVariant FlightsController::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < rowCount())
    {

        FlightInfo *flightInfo = m_flightsList[index.row()];

        //        switch((Role) role) {
        switch (role)
        {
        case CallsignRole:
            return flightInfo->callsign();
        case PlaneNameRole:
            return flightInfo->planeName();
        case FlightStatusRole:
            return flightInfo->flightStatus();
        case DepartureTimeRole:
            return flightInfo->departureTime();
        case ArrivalTimeRole:
            return flightInfo->arrivalTime();
        }
    }
    return {};
}

void FlightsController::addFlight(const QString &callsign, const QString &planeName, int flightStatus, const QDateTime &departureTime, const QDateTime &arrivalTime)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    FlightInfo *newFlightInfo = new FlightInfo(this);
    newFlightInfo->setCallsign(callsign);
    newFlightInfo->setPlaneName(planeName);
    newFlightInfo->setFlightStatus(flightStatus);
    newFlightInfo->setDepartureTime(departureTime);
    newFlightInfo->setArrivalTime(arrivalTime);

    m_flightsList.append(newFlightInfo);
    endInsertRows();
}

QHash<int, QByteArray> FlightsController::roleNames() const
{
    QHash<int, QByteArray> filterRoles;
    filterRoles[CallsignRole] = "callsignData";
    filterRoles[PlaneNameRole] = "planeNameData";
    filterRoles[FlightStatusRole] = "flightStatusData";
    filterRoles[DepartureTimeRole] = "departureTimeData";
    filterRoles[ArrivalTimeRole] = "arrivalTimeData";

    // TODO: more filters

    return filterRoles;
}

void FlightsController::loadFlightsOnTimer()
{
    loadFlights();      // load flights first time
    m_loadFligthsTimer.start(5000); // 5000 milliseconds = 5 seconds
}

void FlightsController::loadFlights()
{
    // Check auth token presence and implement its usage
    if (m_userJwtAuthorizationToken.isEmpty())
    {
        qDebug() << "No token set";
        return;
    }

    QNetworkRequest request;
    m_loadFligthsTimer.start(30000);
    m_loadFligthsTimer.setSingleShot(true);
    request.setUrl(QUrl(RequestConstants::SERVER_BASE_URL + RequestConstants::FLIGHTS_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_userJwtAuthorizationToken.toUtf8()); // Add bearer token header

    QNetworkReply *reply = m_networkManager->get(request);

    // Connect the reply finished signal to process the response
    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleFligthsLoadNetworkReply(reply); });
}

void FlightsController::handleFligthsLoadNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (!jsonResponse.isArray())
    {
        // Handle invalid JSON format
        qCritical() << "Flights: Failed to parse retrieved data into JSON document.";
        return;
    }

    QJsonArray jsonArray = jsonResponse.array();
    for (const QJsonValue &value : jsonArray)
    {
        if (!value.isObject())
        {
            // Handle invalid JSON format
            qDebug() << "value: " << value;
            qCritical() << "Flights: Failed to parse JSON document.";
            continue;
        }

        QJsonObject jsonObject = value.toObject();

        QString callsign = jsonObject.value("callsign").toString();
        QString planeName = jsonObject.value("airport_id").toString();
        int flightStatus = 1; // jsonObject.value("approval_status").toString();
        QDateTime departureTime = QDateTime::fromString(jsonObject.value("start_time").toString(), Qt::ISODate);
        QDateTime arrivalTime = QDateTime::fromString(jsonObject.value("end_time").toString(), Qt::ISODate);

        addFlight(callsign, planeName, flightStatus, departureTime, arrivalTime);
    }
    reply->deleteLater();
}

QString FlightsController::getUserJwtAuthorizationToken() const
{
    return m_userJwtAuthorizationToken;
}

void FlightsController::setUserJwtAuthorizationToken(const QString &token)
{
    m_userJwtAuthorizationToken = token;
}

QNetworkAccessManager *FlightsController::getNetworkManager() const
{
    return m_networkManager;
}

void FlightsController::setNetworkManager(QNetworkAccessManager *networkManager)
{
    m_networkManager = networkManager;
}

FlightsFilterProxyModel *FlightsController::getFilterProxyModel()
{
    return &m_filterProxyModel;
}

// FlightsFilterProxyModel &FlightsController::getFilterProxyModel() const
// {
//     return m_filterProxyModel;
// }

void FlightsController::setFilterProxyModel(const FlightsFilterProxyModel &filterProxyModel)
{
    // TODO:
    // m_filterProxyModel = &filterProxyModel;
}

 void FlightsController::fligthScreenClosed(){
        m_loadFligthsTimer.stop();
 }
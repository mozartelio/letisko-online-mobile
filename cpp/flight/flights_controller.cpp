#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QString>
#include <QDebug>
#include <QPair>

#include "flights_controller.h"
#include "cpp/constants.h"
#include "cpp/server_sent_events_parser.h"
#include "flight_request_status.h"

FlightsController::FlightsController(QNetworkAccessManager *networkManager)
{
    setNetworkManager(networkManager);
    m_flightsModel = new FlightsModel();

    connect(this, &FlightsController::activeScreenChanged, this, &FlightsController::loadFlights);
    subscribeToFlightsUpdates();
}

FlightsController::~FlightsController()
{
    deleteFlightModel();
}

void FlightsController::subscribeToFlightsUpdates()
{
    QNetworkRequest request;

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::UPDATE_SUBSCRIPTION_STREAM_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    QNetworkReply *reply = m_networkManager->get(request);

    QObject::connect(reply, &QNetworkReply::readyRead, this, [this, reply]()
                     { handleFlightsUpdateNetworkReply(reply); });
}

void FlightsController::deleteFlightModel()
{
    delete m_flightsModel;
    m_flightsModel = nullptr;
}

void FlightsController::loadFlights()
{
    // avoid loading flights if the screen is not active
    if (!m_isActiveScreen)
    {
        return;
    }

    // Check auth token presence and implement its usage
    if (m_userJwtAuthorizationToken.isEmpty())
    {
        qWarning() << "Flights controller: no auth token set for loading flights";
        setIsLoadingFlights(true);
        QTimer::singleShot(RequestConstants::REQUEST_RETRY_TIMEOUT_MILLISECONDS, this, &FlightsController::loadFlights);
        return;
    }

    QNetworkRequest request;
    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);
    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::FLIGHTS_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_userJwtAuthorizationToken.toUtf8()); // Add bearer token header

    QNetworkReply *reply = m_networkManager->get(request);

    // Connect the reply finished signal to process the response
    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleFlightsLoadNetworkReply(reply); });
}

void FlightsController::handleFlightsLoadNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (!jsonResponse.isArray())
    {
        // Handle invalid JSON format or server absence (error also heppens when server is switched off)
        qCritical() << "Flights controller: Failed to parse retrieved data into JSON document:";
        return;
    }

    setIsLoadingFlights(false);
    m_flightsModel->removeAllFlights(); // remove old flights
    QJsonArray jsonArray = jsonResponse.array();
    for (const QJsonValue &value : jsonArray)
    {
        if (!value.isObject())
        {
            qCritical() << "Flights: Failed to parse JSON document.";
            continue;
        }

        QJsonObject jsonObject = value.toObject();

        QString callsign = jsonObject.value("callsign").toString();
        QString departureAirport = jsonObject.value("airport_id").toString();
        QString arrivalAirportData = jsonObject.value("arrive_toairport_id").toString();
        FlightRequestStatus::Status flightStatus = FlightRequestStatus::instance()->stringToStatus(jsonObject.value("approval_status").toString());
        QDateTime departureTime = QDateTime::fromString(jsonObject.value("start_time").toString(), Qt::ISODate);
        QDateTime arrivalTime = QDateTime::fromString(jsonObject.value("end_time").toString(), Qt::ISODate);
        unsigned int maxHeight = jsonObject.value("max_height").toInt();
        QString maxHeightMeasureUnits = jsonObject.value("height_level_unit_abbr").toString();
        unsigned int flightRequestId = jsonObject.value("request_id").toInt();
        m_flightsModel->addFlight(callsign, departureAirport, arrivalAirportData, flightStatus, departureTime, arrivalTime, maxHeight, maxHeightMeasureUnits, flightRequestId);
    }
    reply->deleteLater();
}

void FlightsController::handleFlightsUpdateNetworkReply(QNetworkReply *reply)
{
    QByteArray eventData = reply->readAll();
    QPair<QString, QString> parsedData = ServerSentEventsParser::parseSseResponse(eventData);

    QString eventType = parsedData.first;

    // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT: try to parse the event data as JSON?!
    if (eventType == RequestConstants::UPDATE_FLIGHTS_TYPE || eventType == RequestConstants::UPDATE_FLIGTH_STATUS_TYPE)
    {
        loadFlights();
    }
};

void FlightsController::changeFlightRequestStatus(unsigned int flightRequestId, unsigned int status)
{
    if (m_userJwtAuthorizationToken.isEmpty())
    {
        qWarning() << "Flights controller: no auth token set for changing flight status";
        QTimer::singleShot(RequestConstants::REQUEST_RETRY_TIMEOUT_MILLISECONDS, this, [this, flightRequestId, status]()
                           { changeFlightRequestStatus(flightRequestId, status); });
        return;
    }

    QNetworkRequest request;
    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);
    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::CHANGE_FLIGHT_STATUS_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_userJwtAuthorizationToken.toUtf8()); // Add bearer token header

    QJsonObject jsonObject;
    jsonObject.insert("request_id", QString::number(flightRequestId));
    jsonObject.insert("approval_status", (FlightRequestStatus::instance()->statusToString(static_cast<FlightRequestStatus::Status>(status))));

    QJsonDocument jsonDocument(jsonObject);
    QByteArray jsonData = jsonDocument.toJson();

    QNetworkReply *reply = m_networkManager->post(request, jsonData);

    // Connect the reply finished signal to process the response
    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleChangeFlightRequestStatusNetworkReply(reply); });
}

void FlightsController::handleChangeFlightRequestStatusNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (!jsonResponse.isObject())
    {
        // Handle invalid JSON format or server absence (error also heppens when server is switched off)
        qCritical() << "Flights: Failed to parse retrieved data into JSON document:";
        return;
    }
    loadFlights();
    QJsonObject jsonObject = jsonResponse.object();
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

FlightsModel *FlightsController::getFlightsModel() const
{
    return m_flightsModel;
}

void FlightsController::setFlightsModel(FlightsModel *model)
{
    m_flightsModel = model;
}

bool FlightsController::isLoadingFlights() const { return m_isLoadingFlights; }

void FlightsController::setIsLoadingFlights(bool isLoading)
{
    if (m_isLoadingFlights != isLoading)
    {
        m_isLoadingFlights = isLoading;
        emit loadingFlightsChanged();
    }
}

bool FlightsController::isActiveScreen() const
{
    return m_isActiveScreen;
}

void FlightsController::setIsActiveScreen(bool isActive)
{
    if (m_isActiveScreen != isActive)
    {
        m_isActiveScreen = isActive;
        emit activeScreenChanged();
    }
}

#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QString>
#include <QDebug>
#include <QPair>

#include "flights_controller.h"
#include "constants.h"
#include "server_sent_events_parser.h"

FlightsController::FlightsController(QNetworkAccessManager *networkManager)
{
    qDebug() << "hello from FlightsController";
    setNetworkManager(networkManager);
    m_flightsModel = new FlightsModel();

    connect(this, &FlightsController::isActiveScreenChanged, this, &FlightsController::loadFlights);
    subscribeToFlightsUpdates();
}

FlightsController::~FlightsController()
{
    qDebug() << "FlightsController destructor";
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
        qDebug() << "Not an active screen";
        return;
    }

    // Check auth token presence and implement its usage
    if (m_userJwtAuthorizationToken.isEmpty())
    {
        // qDebug() << "No auth token set";
        setIsLoadingFlights(true);
        QTimer::singleShot(RequestConstants::REQUEST_RETRY_TIMEOUT_MILLISECONDS, this, &FlightsController::loadFlights);
        return;
    }
    qDebug() << "Loading flights...";

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
        qCritical() << "Flights: Failed to parse retrieved data into JSON document:";
        qDebug() << "rawResponseData: " << rawResponseData;
        return;
    }

    setIsLoadingFlights(false);
    m_flightsModel->removeAllFlights(); // remove old flights
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
        // TODO: Add REAL plane name to the model
        QString departureAirport = jsonObject.value("airport_id").toString();
        QString arrivalAirportData = jsonObject.value("arrive_toairport_id").toString();
        // TODO: Add REAL APROVAL STATUS to the model
        QString textFlightStatus = jsonObject.value("approval_status").toString();

        int flightStatus;
        // TODO: expose constants for flight status from c++ to qml
        if (textFlightStatus == "Approved")
        {
            flightStatus = 1;
        }
        else if (textFlightStatus == "Denied")
        {
            flightStatus = 0;
        }
        else if (textFlightStatus == "Pending")
        {
            flightStatus = 2;
        }
        else
        {
            flightStatus = -1;
        }

        QDateTime departureTime = QDateTime::fromString(jsonObject.value("start_time").toString(), Qt::ISODate);
        QDateTime arrivalTime = QDateTime::fromString(jsonObject.value("end_time").toString(), Qt::ISODate);
        unsigned int maxHeight = jsonObject.value("max_height").toInt();
        QString maxHeightMeasureUnits = jsonObject.value("height_level_unit_abbr").toString();

        qDebug() << "Adding flights to the model...";
        m_flightsModel->addFlight(callsign, departureAirport, arrivalAirportData, flightStatus, departureTime, arrivalTime, maxHeight, maxHeightMeasureUnits);
    }
    reply->deleteLater();
}

void FlightsController::handleFlightsUpdateNetworkReply(QNetworkReply *reply)
{
    qDebug() << "Subscribing to updates RECIEVED...processing...";
    QByteArray eventData = reply->readAll();
    QPair<QString, QString> parsedData = ServerSentEventsParser::parseSseResponse(eventData);

    QString eventType = parsedData.first;

    // try to parse the event data as JSON?!
    qDebug() << "Received event - Type:" << eventType;

    if (eventType == RequestConstants::UPDATE_FLIGHTS_TYPE)
    {
        loadFlights();
    }
};

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
        emit isLoadingFlightsChanged();
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
        emit isActiveScreenChanged();
    }
}

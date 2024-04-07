#include <QNetworkReply>
#include <QJsonDocument>
#include <QNetworkRequest>
#include <QJsonArray>
#include <QJsonObject>
#include <QString>
#include <QDebug>
#include "flights_controller.h"
#include "request_constants.h"

FlightsController::FlightsController(QNetworkAccessManager *networkManager)
{
    qDebug() << "hello from FlightsController";
    setNetworkManager(networkManager);
    m_flightsModel = new FlightsModel();
    connect(&m_loadFligthsTimer, &QTimer::timeout, this, &FlightsController::loadFlights);

    // // TEST
    // QNetworkRequest request(QUrl("http://127.0.0.1:5001/stream"));
    // QNetworkReply *reply = networkManager->get(request);

    // QObject::connect(reply, &QNetworkReply::readyRead, [reply]
    //                  {
    //     QByteArray eventData = reply->readAll();
    //     QString eventString(eventData);
    //     qDebug() << "Received event:" << eventString; });
}

FlightsController::~FlightsController()
{
    qDebug() << "FlightsController destructor";
    deleteFligthModel();
}

void FlightsController::deleteFligthModel()
{
    delete m_flightsModel;
    m_flightsModel = nullptr;
}

void FlightsController::loadFlightsOnTimer()
{
    loadFlights(); // load flights first time
    m_loadFligthsTimer.start(RequestConstants::FLIGHTS_RELOAD_TIMER_MILLISECONDS);
}

void FlightsController::loadFlights()
{
    // Check auth token presence and implement its usage
    if (m_userJwtAuthorizationToken.isEmpty())
    {
        qDebug() << "No auth token set";
        setIsLoadingFlights(true);
        return;
    }
    qDebug() << "Loading flights...";

    QNetworkRequest request;
    m_request_timer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_request_timer.setSingleShot(true);
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
        // Handle invalid JSON format or server absence
        qCritical() << "Flights: Failed to parse retrieved data into JSON document.";
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
        QString planeName = jsonObject.value("airport_id").toString();
        // TODO: Add REAL APROVAL STATUS to the model
        int flightStatus = 1; // jsonObject.value("approval_status").toString();
        QDateTime departureTime = QDateTime::fromString(jsonObject.value("start_time").toString(), Qt::ISODate);
        QDateTime arrivalTime = QDateTime::fromString(jsonObject.value("end_time").toString(), Qt::ISODate);

        qDebug() << "Adding flights to the model...";
        m_flightsModel->addFlight(callsign, planeName, flightStatus, departureTime, arrivalTime);
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

FlightsModel *FlightsController::getFlightsModel() const
{
    return m_flightsModel;
}

void FlightsController::setFlightsModel(FlightsModel *model)
{
    m_flightsModel = model;
}

void FlightsController::fligthScreenClosed()
{
    m_loadFligthsTimer.stop();
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

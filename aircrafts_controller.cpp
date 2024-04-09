#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

#include "aircrafts_controller.h"
#include "request_constants.h"
#include "server_sent_events_parser.h"

AircraftsController::AircraftsController(QNetworkAccessManager *networkManager)
{
    qDebug() << "hello from AircraftsController";
    setNetworkManager(networkManager);
    m_aircraftsModel = new AircraftsModel();

    connect(this, &AircraftsController::isActiveScreenChanged, this, &AircraftsController::loadAircrafts);
    subscribeToAircraftsUpdates();
}

AircraftsController::~AircraftsController()
{
    qDebug() << "AircraftsController destructor";
    deleteFlightModel();
}

void AircraftsController::subscribeToAircraftsUpdates()
{
    QNetworkRequest request;

    request.setUrl(QUrl(RequestConstants::SERVER_BASE_URL + RequestConstants::UPDATE_SUBSCRIPTION_STREAM_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    QNetworkReply *reply = m_networkManager->get(request);

    QObject::connect(reply, &QNetworkReply::readyRead, this, [this, reply]()
                     { handleAircraftsUpdateNetworkReply(reply); });
}

void AircraftsController::deleteFlightModel()
{
    delete m_aircraftsModel;
    m_aircraftsModel = nullptr;
}

void AircraftsController::loadAircrafts()
{
    // avoid loading aircrafts if the screen is not active
    if (!m_isActiveScreen)
    {
        qDebug() << "Not an active screen";
        return;
    }

    // Check auth token presence and implement its usage
    if (m_userJwtAuthorizationToken.isEmpty())
    {
        qDebug() << "No auth token set";
        setIsLoadingAircrafts(true);
        QTimer::singleShot(RequestConstants::REQUEST_RETRY_TIMEOUT_MILLISECONDS, this, &AircraftsController::loadAircrafts); // Retry after 5 seconds
        return;
    }
    qDebug() << "Loading aircrafts...";

    QNetworkRequest request;
    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);
    request.setUrl(QUrl(RequestConstants::SERVER_BASE_URL + RequestConstants::AIRCRAFTS_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_userJwtAuthorizationToken.toUtf8()); // Add bearer token header

    QNetworkReply *reply = m_networkManager->get(request);

    // Connect the reply finished signal to process the response
    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleAircraftsLoadNetworkReply(reply); });
}

void AircraftsController::handleAircraftsLoadNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (!jsonResponse.isArray())
    {
        // Handle invalid JSON format or server absence (error also heppens when server is switched off)
        qCritical() << "Aircrafts: Failed to parse retrieved data into JSON document:";
        qDebug() << "rawResponseData: " << rawResponseData;
        return;
    }

    setIsLoadingAircrafts(false);
    m_aircraftsModel->removeAllFlights(); // remove old flights
    QJsonArray jsonArray = jsonResponse.array();
    for (const QJsonValue &value : jsonArray)
    {
        if (!value.isObject())
        {
            // Handle invalid JSON format
            qDebug() << "value: " << value;
            qCritical() << "Aircrafts: Failed to parse JSON document.";
            continue;
        }

        QJsonObject jsonObject = value.toObject();
        QString serialNumber = jsonObject.value("serial_number").toString();
        double totalTimeFlown = jsonObject.value("total_time_flown").toString().toDouble();
        QString timeUnitName = jsonObject.value("time_measure_unit").toString();
        QString registrationState = jsonObject.value("state").toString();
        QString aircraftType = jsonObject.value("aircraft_type").toString();
        QString flightRules = jsonObject.value("flight_rule").toString();
        QString planeName = jsonObject.value("name").toString();
        QString icaoWakeTurbulenceCategory = jsonObject.value("iwtc").toString();

        qDebug() << "Adding aircrafts to the model...";
        // stubs for remaining fields for futer API updates
        m_aircraftsModel->addAircraft(serialNumber, totalTimeFlown, timeUnitName, registrationState, aircraftType, flightRules, planeName, icaoWakeTurbulenceCategory, QString(), QString(), QString(), QDate(), QUrl());
    }
    reply->deleteLater();
}

void AircraftsController::handleAircraftsUpdateNetworkReply(QNetworkReply *reply)
{
    qDebug() << "Subscribing to updates RECIEVED...processing...";
    QByteArray eventData = reply->readAll();
    QPair<QString, QString> parsedData = ServerSentEventsParser::parseSseResponse(eventData);

    QString eventType = parsedData.first;

    // try to parse the event data as JSON?!
    qDebug() << "Received event - Type:" << eventType;

    if (eventType == RequestConstants::UPDATE_AIRCRAFTS_TYPE)
    {
        loadAircrafts();
    }
};

QString AircraftsController::getUserJwtAuthorizationToken() const
{
    return m_userJwtAuthorizationToken;
}

void AircraftsController::setUserJwtAuthorizationToken(const QString &token)
{
    m_userJwtAuthorizationToken = token;
}

QNetworkAccessManager *AircraftsController::getNetworkManager() const
{
    return m_networkManager;
}

void AircraftsController::setNetworkManager(QNetworkAccessManager *networkManager)
{
    m_networkManager = networkManager;
}

AircraftsModel *AircraftsController::getAircraftsModel() const
{
    return m_aircraftsModel;
}

void AircraftsController::setAircraftsModel(AircraftsModel *model)
{
    m_aircraftsModel = model;
}

bool AircraftsController::isLoadingAircrafts() const { return m_isLoadingAircrafts; }

void AircraftsController::setIsLoadingAircrafts(bool isLoading)
{
    if (m_isLoadingAircrafts != isLoading)
    {
        m_isLoadingAircrafts = isLoading;
        emit isLoadingAircraftsChanged();
    }
}

bool AircraftsController::isActiveScreen() const
{
    return m_isActiveScreen;
}

void AircraftsController::setIsActiveScreen(bool isActive)
{
    if (m_isActiveScreen != isActive)
    {
        m_isActiveScreen = isActive;
        emit isActiveScreenChanged();
    }
}

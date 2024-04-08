#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>
#include "request_constants.h"
#include "user_controller.h"

UserController::UserController(QObject *parent)
    : QObject{parent}
{
    qDebug() << "UserController hello from after 00:00";
    m_networkManager = new QNetworkAccessManager();
    m_flightsController = new FlightsController(m_networkManager);
    m_aircraftsController = new AircraftsController(m_networkManager);
}

UserController::~UserController()
{
    qDebug() << "UserController destructor";
    // m_flightsController is a pointer
    delete m_flightsController;
    m_flightsController = nullptr; // Set the pointer to nullptr to avoid dangling pointer

    delete m_aircraftsController;
    m_aircraftsController = nullptr;

    delete m_networkManager;
    m_networkManager = nullptr;
}

// std::pair<bool, QString> extractJsonKeyValueFromRaw(const QByteArray &rawResponseData, const QString &jsonKeyName)
// {
//     QJsonDocument doc = QJsonDocument::fromJson(rawResponseData);
//     QString internalServerProblem = "Internal server problem";
//     if (doc.isNull())
//     {
//         qCritical() << "Failed to parse JSON document.";
//         return std::make_pair(false, internalServerProblem);
//     }

//     QJsonObject obj = doc.object();

//     if (!obj.contains(jsonKeyName))
//     {
//         qCritical() << QString("JSON object does not contain a \"%1\" key").arg(jsonKeyName);
//         return std::make_pair(false, internalServerProblem);
//     }

//     QJsonValue jsonKeyValue = obj[jsonKeyName];

//     if (!jsonKeyValue.isString())
//     {
//         qCritical() << QString("\"%1\" value is not a string ").arg(jsonKeyName);
//         return std::make_pair(false, internalServerProblem);
//     }
//     return std::make_pair(true, jsonKeyValue.toString());
// }

/**
 * @brief Performs a login operation using the provided email and password.
 *
 * This method sends a network request to the server to authenticate the user
 * using the provided email and password. It expects a JSON response from the server
 * containing an access token if the login is successful.
 *
 * @param email The email address of the user.
 * @param password The password of the user.
 */
void UserController::doLogin(const QString &email, const QString &password)
{
    QNetworkRequest request;
    qDebug() << "email: " << email;
    qDebug() << "password: " << password;

    m_request_timer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_request_timer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_BASE_URL + RequestConstants::LOGIN_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);

    QJsonObject json;
    json.insert("email", email);
    json.insert("password", password);
    QByteArray jsonData = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_networkManager->post(request, jsonData);

    // qDebug() << "request is: " << request.url().toString();
    // qDebug() << "data is: " << jsonData;

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleLoginNetworkReply(reply); });
}

void UserController::handleLoginNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QString internalServerProblemDescription = "Internal server problem";

    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (jsonResponse.isNull())
    {
        qCritical() << "Failed to parse JSON document.";
        emit loginResult(internalServerProblemDescription);
    }
    QJsonObject jsonObject = jsonResponse.object();

    if (reply->error() == QNetworkReply::NoError)
    {
        if (jsonObject.contains("access_token"))
        {
            emit loginResult(true);
            m_jwtAuthorizationToken = jsonObject["access_token"].toString();
            qDebug() << "auth token: " << m_jwtAuthorizationToken;
            setControllersParams();
        }
        else
        {
            qCritical() << QString("JSON object does not contain a \"access_token\" key");
            emit loginResult(internalServerProblemDescription);
        }
    }
    else
    {
        QString errorMessage = jsonObject.contains("message") ? jsonObject["message"].toString() : reply->errorString();
        emit loginResult(errorMessage);
    }
    reply->deleteLater();
}

void UserController::setControllersParams()
{
    m_flightsController->setUserJwtAuthorizationToken(m_jwtAuthorizationToken);
    m_aircraftsController->setUserJwtAuthorizationToken(m_jwtAuthorizationToken);
}

Q_INVOKABLE FlightsController *UserController::getFlightsController() const
{
    return m_flightsController;
}

void UserController::setFlightsController(FlightsController *controller) { m_flightsController = controller; }

Q_INVOKABLE AircraftsController *UserController::getAircraftsController() const
{
    return m_aircraftsController;
}

void UserController::setAircraftsController(AircraftsController *controller)
{
    m_aircraftsController = controller;
}

bool UserController::doRegister(const QString &email, const QString &password)
{
    // TODO:
    return true;
}

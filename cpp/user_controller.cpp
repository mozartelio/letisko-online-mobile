#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>

#include "constants.h"
#include "user_controller.h"

UserController::UserController(QObject *parent)
    : QObject{parent}
{
    m_networkManager = new QNetworkAccessManager();
    m_flightsController = new FlightsController(m_networkManager);
    m_aircraftsController = new AircraftsController(m_networkManager);
    m_user = new User(m_networkManager);
}

UserController::~UserController()
{
    delete m_flightsController;
    m_flightsController = nullptr; // Set the pointer to nullptr to avoid dangling pointer

    delete m_aircraftsController;
    m_aircraftsController = nullptr;

    delete m_networkManager;
    m_networkManager = nullptr;

    delete m_user;
    m_user = nullptr;
}

void UserController::doLogout()
{
    m_user->removeUserInfo();
    m_jwtAuthorizationToken.clear();

    m_flightsController->setUserJwtAuthorizationToken(m_jwtAuthorizationToken);
    m_aircraftsController->setUserJwtAuthorizationToken(m_jwtAuthorizationToken);
}

bool UserController::isUserLoggedIn()
{
    return !m_jwtAuthorizationToken.isEmpty();
}

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

    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::LOGIN_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);

    QJsonObject json;
    json.insert("email", email);
    json.insert("password", password);
    QByteArray jsonData = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_networkManager->post(request, jsonData);

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
        qCritical() << "UserController : Failed to parse JSON document.";
        emit loginResult(internalServerProblemDescription);
    }
    QJsonObject jsonObject = jsonResponse.object();

    if (reply->error() == QNetworkReply::NoError)
    {
        if (jsonObject.contains("access_token"))
        {
            emit loginResult(true);
            m_jwtAuthorizationToken = jsonObject["access_token"].toString();
            performAfterAuthActions();
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

void UserController::performAfterAuthActions()
{
    m_flightsController->setUserJwtAuthorizationToken(m_jwtAuthorizationToken);
    m_aircraftsController->setUserJwtAuthorizationToken(m_jwtAuthorizationToken);
    m_user->setJwtAuthorizationToken(m_jwtAuthorizationToken);
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

User *UserController::getUser() const
{
    return m_user;
}

void UserController::setUser(User *user)
{
    m_user = user;
    emit userChanged();
}

void UserController::doRegistration(const QString &email, const QString &password)
{
    QNetworkRequest request;

    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::REGISTRATION_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);

    QJsonObject json;
    json.insert("email", email);
    json.insert("password", password);
    json.insert("confirmationPassword", password);
    QByteArray jsonData = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_networkManager->post(request, jsonData);

    connect(reply, &QNetworkReply::finished, this, [this, reply, email, password]()
            { handleRegistrationNetworkReply(reply, email, password); });
}

void UserController::handleRegistrationNetworkReply(QNetworkReply *reply, QString email, QString password)
{
    QByteArray rawResponseData = reply->readAll();
    QString internalServerProblemDescription = "Internal server problem";

    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (jsonResponse.isNull())
    {
        qCritical() << "UserController : Failed to parse JSON document.";
        emit registrationResult(internalServerProblemDescription);
    }
    QJsonObject jsonObject = jsonResponse.object();

    if (reply->error() == QNetworkReply::NoError)
    {
        // API does not return a AUTH token after registration, soit need to be retriewed by calling doLogin
        doLogin(email, password);

        PersonalInfo *usersInfo = m_user->getPersonalInfo();
        if (usersInfo == nullptr)
        {
            usersInfo = new PersonalInfo();
            m_user->setPersonalInfo(usersInfo);
        }
        usersInfo->setEmail(email);
        emit profileDetailsFilledInResult(true);

        emit registrationResult(true);
    }
    else
    {
        QString errorMessage = jsonObject.contains("message") ? jsonObject["message"].toString() : reply->errorString();
        emit registrationResult(errorMessage);
    }
    reply->deleteLater();
}

void UserController::fillInProfileDetails(const QString &name, const QString &surname, const QString &street, const QString &buildingNumber, const QString &zipCode, const QString &city, const QString &state)
{
    QNetworkRequest request;
    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::PROFILE_DETAILS_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_jwtAuthorizationToken.toUtf8());

    QJsonObject json;
    json.insert("name", name);
    json.insert("surname", surname);
    json.insert("street", street);
    json.insert("building_number", buildingNumber);
    json.insert("zip_code", zipCode);
    json.insert("city", city);
    json.insert("state", state);
    QByteArray jsonData = QJsonDocument(json).toJson();

    PersonalInfo *usersInfo = m_user->getPersonalInfo();
    if (usersInfo == nullptr)
    {
        usersInfo = new PersonalInfo();
        m_user->setPersonalInfo(usersInfo);
    }
    usersInfo->setName(name);
    usersInfo->setSurname(surname);

    Address *usersAddress = m_user->getAddress();
    if (usersAddress == nullptr)
    {
        usersAddress = new Address();
        m_user->setAddress(usersAddress);
    }
    usersAddress->setStreet(street);
    usersAddress->setBuildingNumber(buildingNumber);
    usersAddress->setZipCode(zipCode);
    usersAddress->setCity(city);
    usersAddress->setState(state);
    m_user->requestAvatar();

    QNetworkReply *reply = m_networkManager->post(request, jsonData);

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleProfileDetailsNetworkReply(reply); });
}

void UserController::handleProfileDetailsNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QString internalServerProblemDescription = "Internal server problem";

    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (jsonResponse.isNull())
    {
        qCritical() << "UserController : Failed to parse JSON document.";
        emit profileDetailsFilledInResult(internalServerProblemDescription);
    }
    QJsonObject jsonObject = jsonResponse.object();

    if (reply->error() == QNetworkReply::NoError)
    {
        //  #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT: sendChangeRoleRequest();
        emit profileDetailsFilledInResult(true);
    }
    else
    {
        QString errorMessage = jsonObject.contains("message") ? jsonObject["message"].toString() : reply->errorString();
        emit profileDetailsFilledInResult(errorMessage);
    }
    reply->deleteLater();
}

void UserController::sendChangeRoleRequest()
{
    QNetworkRequest request;

    m_requestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_requestTimer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::CHANGE_ROLE_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_jwtAuthorizationToken.toUtf8());

    QJsonObject json;
    json.insert("user_email", m_user->getPersonalInfo()->getEmail());
    json.insert("new_role", "control_man");
    json.insert("qualification_start_date", "2000-00-00T00:00:00");
    json.insert("qualification_end_date", "3000-00-00T00:00:00");
    json.insert("airport", "Letisko Košice");
    QByteArray jsonData = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_networkManager->post(request, jsonData);

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleChangeRoleReply(reply); });
}

void UserController::handleChangeRoleReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QString internalServerProblemDescription = "Internal server problem";

    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (jsonResponse.isNull())
    {
        qCritical() << "UserController : Failed to parse JSON document.";
        emit changeRoleResult(internalServerProblemDescription);
    }
    QJsonObject jsonObject = jsonResponse.object();

    if (reply->error() == QNetworkReply::NoError)
    {
        emit changeRoleResult(true);
    }
    else
    {
        QString errorMessage = jsonObject.contains("message") ? jsonObject["message"].toString() : reply->errorString();
        emit changeRoleResult(errorMessage);
    }
    reply->deleteLater();
}

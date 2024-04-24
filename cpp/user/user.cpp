#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>
#include <QPixmap>

#include "user.h"
#include "personal_info.h"
#include "cpp/constants.h"
#include "cpp/pixmap_provider.h"

User::User(QNetworkAccessManager *networkManager, QObject *parent) : QObject{parent}
{
    m_avatar = QPixmap();
    m_personalInfo = nullptr;
    m_address = nullptr;
    m_networkManager = networkManager;
}

User::~User()
{
    delete m_personalInfo;
    m_personalInfo = nullptr;

    delete m_address;
    m_address = nullptr;
}

void User::removeUserInfo()
{
    delete m_personalInfo;
    m_personalInfo = nullptr;

    delete m_address;
    m_address = nullptr;

    m_avatar = QPixmap();
    PixmapProvider::instance()->removePixmap(m_avatarPixmapProviderId);
}

void User::requestPersonalInfoAndAddress()
{
    QNetworkRequest request;
    m_personalInfoRequestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_personalInfoRequestTimer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::PROFILE_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_jwtAuthorizationToken.toUtf8());

    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handlePersonalInfoNetworkReply(reply); });
}

void User::handlePersonalInfoNetworkReply(QNetworkReply *reply)
{
    QByteArray rawResponseData = reply->readAll();
    QString internalServerProblemDescription = "Internal server problem";

    QJsonDocument jsonResponse = QJsonDocument::fromJson(rawResponseData);
    if (jsonResponse.isNull())
    {
        qCritical() << "User : Failed to parse personal info reply JSON document.";
        return;
    }
    QJsonObject jsonObject = jsonResponse.object();

    if (reply->error() == QNetworkReply::NoError)
    {
        if (jsonObject.contains("email") && jsonObject.contains("name") && jsonObject.contains("surname") && jsonObject.contains("building_number") && jsonObject.contains("city") && jsonObject.contains("street") && jsonObject.contains("state") && jsonObject.contains("zip_code"))
        {
            QString email = jsonObject["email"].toString();
            QString name = jsonObject["name"].toString();
            QString surname = jsonObject["surname"].toString();

            QString buildingNumber = jsonObject.value("building_number").toString();
            QString city = jsonObject.value("city").toString();
            QString street = jsonObject.value("street").toString();
            QString state = jsonObject.value("state").toString();
            QString zipCode = jsonObject.value("zip_code").toString();

            m_address = new Address(buildingNumber, city, street, state, zipCode);

            if(m_personalInfo !=nullptr) {
                delete m_personalInfo;
                m_personalInfo = nullptr;

            }
            m_personalInfo = new PersonalInfo(email, name, surname);

            emit personalInfoChanged(m_personalInfo);
            emit addressChanged(m_address);
        }
        else
        {
            qCritical() << QString("Profile JSON object is missing required key/s");
        }
    }
    else
    {
        QString errorMessage = jsonObject.contains("message") ? jsonObject["message"].toString() : reply->errorString();
        qCritical() << errorMessage;
    }
    reply->deleteLater();
}

void User::requestAvatar()
{
    QNetworkRequest request;
    m_personalInfoRequestTimer.start(RequestConstants::REQUEST_TIMEOUT_MILLISECONDS);
    m_personalInfoRequestTimer.setSingleShot(true);

    request.setUrl(QUrl(RequestConstants::SERVER_REQUEST_URL_AND_PORT + RequestConstants::AVATAR_ENDPOINT));
    request.setRawHeader("Content-Type", RequestConstants::CONTENT_TYPE);
    request.setRawHeader("User-Agent", RequestConstants::USER_AGENT);
    request.setRawHeader("Authorization", "Bearer " + m_jwtAuthorizationToken.toUtf8());

    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            { handleAvatarNetworkReply(reply); });
}

void User::handleAvatarNetworkReply(QNetworkReply *reply)
{
    QByteArray imageData = reply->readAll();
    QPixmap avatar;
    avatar.loadFromData(imageData);

    if (!setAvatar(avatar))
    {
        qCritical() << "Failed to load avatar image.";
    }

    reply->deleteLater();
}

void User::jwtAuthorizationTokenChanged()
{
    requestPersonalInfoAndAddress();
    requestAvatar();
}

PersonalInfo *User::getPersonalInfo() const
{
    return m_personalInfo;
}

void User::setPersonalInfo(PersonalInfo *personalInfo)
{
    if (m_personalInfo != personalInfo)
    {
        m_personalInfo = personalInfo;
        emit personalInfoChanged(m_personalInfo);
    }
}

Address *User::getAddress() const
{
    return m_address;
}

void User::setAddress(Address *address)
{
    if (m_address != address)
    {
        m_address = address;
        emit addressChanged(m_address);
    }
}

QPixmap User::getAvatar() const
{
    return m_avatar;
}

bool User::setAvatar(const QPixmap avatar)
{
    if ((m_avatar.toImage() != avatar.toImage()) && !avatar.isNull())
    {
        m_avatar = avatar;
        PixmapProvider::instance()->removePixmap(m_avatarPixmapProviderId);
        PixmapProvider::instance()->addPixmap(m_avatarPixmapProviderId, m_avatar);
        emit avatarPixmapProviderIdChanged();
        return true;
    }

    return false;
}

QString User::getJwtAuthorizationToken() const
{
    return m_jwtAuthorizationToken;
}

void User::setJwtAuthorizationToken(const QString &jwtAuthorizationToken)
{
    if (jwtAuthorizationToken.isEmpty())
    {
        qWarning() << "Empty auth token set";
        return;
    }

    if (m_jwtAuthorizationToken != jwtAuthorizationToken)
    {
        m_jwtAuthorizationToken = jwtAuthorizationToken;
    }
    jwtAuthorizationTokenChanged();
}

QString User::getAvatarPixmapProviderId() const
{
    return m_avatarPixmapProviderId;
}

bool User::isAvatarPresent() const
{
    return !m_avatar.isNull();
}

#include "user_controller.h"
#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>

namespace
{
    const QString &serverRequestUrlBase = "http://85.237.233.151:51/";
}

struct Endpoints
{
    static inline const QString login = "auth/login";
    static inline const QString registration = "auth/register";
};

struct RawHeaders
{
    static inline const QByteArray contentType = "application/json";
    static inline const QByteArray userAgent = "Mozilla/5.0 (Linux; Android 10;) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36";
};

UserController::UserController(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager();
}

std::pair<bool, QString> extractJsonKeyValueFromRaw(const QByteArray &rawResponseData, const QString &jsonKeyName)
{
    QJsonDocument doc = QJsonDocument::fromJson(rawResponseData);
    QString internalServerProblem = "Internal server problem";
    if (doc.isNull())
    {
        qCritical() << "Failed to parse JSON document.";
        return std::make_pair(false, internalServerProblem);
    }

    QJsonObject obj = doc.object();

    if (!obj.contains(jsonKeyName))
    {
        qCritical() << QString("JSON object does not contain a \"%1\" key").arg(jsonKeyName);
        return std::make_pair(false, internalServerProblem);
    }

    QJsonValue jsonKeyValue = obj[jsonKeyName];

    if (!jsonKeyValue.isString())
    {
        qCritical() << QString("\"%1\" value is not a string ").arg(jsonKeyName);
        return std::make_pair(false, internalServerProblem);
    }
    return std::make_pair(true, jsonKeyValue.toString());
}

void UserController::doLogin(const QString &email, const QString &password)
{
    QNetworkRequest request;
    qDebug() << "email: " << email;
    qDebug() << "password: " << password;

    timer.start(30000);
    timer.setSingleShot(true);

    request.setUrl(QUrl(serverRequestUrlBase + Endpoints::login));
    request.setRawHeader("Content-Type", RawHeaders::contentType);
    request.setRawHeader("User-Agent", RawHeaders::userAgent);

    QJsonObject obj;
    obj["email"] = email;
    obj["password"] = password;
    QJsonDocument doc(obj);
    QByteArray jsonData = doc.toJson();

    // qDebug() << "request is: " << request.url().toString();
    // qDebug() << "data is: " << jsonData;

    QNetworkReply *reply = manager->post(request, jsonData);
    QObject::connect(reply, &QNetworkReply::finished, [=, this]()
                     {
                         QByteArray rawResponseData = reply->readAll();
                         QString contents = QString::fromUtf8(rawResponseData);
                         std::pair<bool, QString> result;
                         // qDebug() << "contents"<<contents;
                         if(reply->error() == QNetworkReply::NoError){
                            //  qDebug() << contents;
                             result = extractJsonKeyValueFromRaw(rawResponseData,"access_token");
                             if(result.first){
                                 emit loginResult(true);
                                 jwtAuthorizationToken = result.second;
                                 // qDebug() << "jwtAuthorizationToken : " << jwtAuthorizationToken;
                             } else{
                                 emit loginResult(result.second);
                             }
                         }
                         else{
                             // QString err = reply->errorString();
                             emit loginResult(extractJsonKeyValueFromRaw(rawResponseData,"message").second);
                             reply->deleteLater();
                         }
                         reply->deleteLater(); });
}

bool UserController::doRegister(const QString &email, const QString &password)
{
    // TODO:
    return true;
}

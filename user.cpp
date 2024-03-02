#include "user.h"
#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>

User::User(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager();
}


bool User::doLogin(const QString& email, const QString& password){
    QNetworkRequest request;
    qDebug() << "email: " << email;
    qDebug() << "password:" << password;


    timer.start(30000);
    timer.setSingleShot(true);

    request.setUrl(QUrl("http://127.0.0.1:5001/auth/login"));
    request.setRawHeader("Content-Type", "application/json");
    request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0");

    QJsonObject obj;
    obj["email"] = email;
    obj["password"] = password;
    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();


    QNetworkReply *reply = manager->post(request, data);
    QObject::connect(reply, &QNetworkReply::finished, [=](){
        if(reply->error() == QNetworkReply::NoError){
            QString contents = QString::fromUtf8(reply->readAll());
            qDebug() << contents;
        }
        else{
            QString err = reply->errorString();
            qDebug() << err;
        }
        reply->deleteLater();
        qDebug() << "falsa";
        return false;
    });
    qDebug() << "reply" << reply;
    qDebug() << reply;
    return true;
}

bool User::doRegister(const QString& email, const QString& password){
    // TODO:
    return true;
}

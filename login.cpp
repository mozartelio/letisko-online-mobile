// #include "login.h"
// #include <QTimer>
// #include <QNetworkAccessManager>
// #include <QNetworkReply>
// #include <QJsonObject>
// #include <QJsonDocument>


// Login::Login(QObject *parent)
//     : QObject{parent}
// {

// }

// void Login::doLogin(const QString& email, const QString& password){
//     qDebug() << "email: " << email;
//     qDebug() << "password:" << password;
//     QTimer timer;
//     QNetworkAccessManager *manager = new QNetworkAccessManager();

//     QNetworkRequest request;
//     timer.start(30000);
//     timer.setSingleShot(true);

//     request.setUrl(QUrl("http://127.0.0.1:5001/auth/login"));
//     request.setRawHeader("Content-Type", "application/json");
//     request.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0");

//     QJsonObject obj;
//     obj["email"] = email;
//     obj["password"] = password;
//     QJsonDocument doc(obj);
//     QByteArray data = doc.toJson();

//     QNetworkReply *reply = manager->post(request, data);
//     QObject::connect(reply, &QNetworkReply::finished, [=](){
//         if(reply->error() == QNetworkReply::NoError){
//             QString contents = QString::fromUtf8(reply->readAll());
//             qDebug() << contents;
//         }
//         else{
//             QString err = reply->errorString();
//             qDebug() << err;
//         }
//         reply->deleteLater();
//     });
//     qDebug() << reply;
// }

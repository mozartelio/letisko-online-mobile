#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QTimer>
#include <QJsonObject>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QQuickItem>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QQuickView>
#include "login.h"
#include "user.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // qmlRegisterType<Login>("com.login", 1, 0, "Login");
    qmlRegisterType<User>("com.user", 1, 0, "User");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("OnlineLetiskoMobileApp", "Main");
    return app.exec();
}


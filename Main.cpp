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
#include <QIcon>
#include <QTranslator>
#include "login.h"
#include "user.h"
#include "hotreload/ComponentCreatorEngine.h"


int main(int argc, char *argv[])
{
    qputenv("MAIN_QML", "../OnlineLetiskoMobileApp/qml/Main.qml");


    // QQuickStyle::setStyle("Material");
    QGuiApplication app(argc, argv);

    // DOES NOT WORK
    // qmlRegisterSingletonType(QUrl("qml/styles/Colors.qml"), "Colors", 1, 0, "Colors");

    QTranslator translator;
    translator.load("slovak.qm");
    app.installTranslator(&translator);

    // qmlRegisterType<Login>("com.login", 1, 0, "Login");
    qmlRegisterType<User>("com.user", 1, 0, "User");
    const QUrl url(qgetenv("MAIN_QML"));

    //for using with hotreload
    ComponentCreatorEngine engine;
    engine.rootContext()->setContextProperty("QmlEngine", &engine);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);


    // for testing without hotreload
    // QQmlApplicationEngine engine;
    // QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
    //     &app, []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);
    // engine.loadFromModule("OnlineLetiskoMobileApp", "Main");

    return app.exec();
}


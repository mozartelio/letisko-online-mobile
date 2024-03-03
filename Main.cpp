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
// #include <QTranslator>
#include "login.h"
#include "user.h"
#include "core/ComponentCreatorEngine.h"
// #include "hotreload.h"


int main(int argc, char *argv[])
{
    qputenv("MAIN_QML", "../OnlineLetiskoMobileApp/qml/Main.qml");


    // QQuickStyle::setStyle("Material");
    QGuiApplication app(argc, argv);
    // QTranslator translator;
    // translator.load(":/translations/slovak");
    // app.installTranslator(&translator);

    // qmlRegisterType<Login>("com.login", 1, 0, "Login");
    qmlRegisterType<User>("com.user", 1, 0, "User");


    ComponentCreatorEngine engine;

    engine.rootContext()->setContextProperty("QmlEngine", &engine);

    const QUrl url(qgetenv("MAIN_QML"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);



    // QQmlApplicationEngine engine;
    // QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
    //     &app, []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);
    // engine.loadFromModule("OnlineLetiskoMobileApp", "Main");

    // Hotreload hotreload(engine, "qml/");
    // engine.rootContext()->setContextProperty("_hotreload", &hotreload);
    // engine.rootContext()->setContextProperty("_qmlPath", QGuiApplication::applicationDirPath() + "/qml/");

    return app.exec();
}


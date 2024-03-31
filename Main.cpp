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
#include <QFontDatabase>
#include <QtQml/qqmlextensionplugin.h>
#include "lostyle.h"
#include "login.h"
#include "user.h"
#include "hotreload/ComponentCreatorEngine.h"

void InstallDefaultFont()
{
    qint32 fontId = QFontDatabase::addApplicationFont(":/fonts/Roboto-Regular.ttf");
    QStringList fontList = QFontDatabase::applicationFontFamilies(fontId);

    QString family = fontList.first();
    QGuiApplication::setFont(QFont(family));
}

int main(int argc, char *argv[])
{
    qputenv("MAIN_QML", "../OnlineLetiskoMobileApp/qml/Main.qml");

    // QQuickStyle::setStyle("Material");
    QGuiApplication app(argc, argv);

    qmlRegisterSingletonType(QUrl("qrc:/UserAppSettings.qml"), "UserAppSettings", 1, 0, "UserAppSettings");

    QTranslator translator;
    translator.load("slovak.qm");
    app.installTranslator(&translator);


    app.setOrganizationName("Letisko online");
    app.setOrganizationDomain("letisko.online");
     app.setApplicationName("Letisko online");

    // qmlRegisterType<Login>("com.login", 1, 0, "Login");
    qmlRegisterType<User>("com.user", 1, 0, "User");
    const QUrl url(qgetenv("MAIN_QML"));
    InstallDefaultFont();

    /**for using with hotreload**/
    ComponentCreatorEngine engine;
    engine.rootContext()->setContextProperty("QmlEngine", &engine);

    /** for testing without hotreload**/
    // QQmlApplicationEngine engine;

    LOStyle *style = new LOStyle( &engine );
    engine.rootContext()->setContextProperty( "__style", style );

    /**for using with hotreload**/
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    /** for testing without hotreload**/
    // QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
    //     &app, []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);
    // engine.loadFromModule("OnlineLetiskoMobileApp", "Main");

    return app.exec();
}

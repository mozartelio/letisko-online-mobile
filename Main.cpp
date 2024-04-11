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

#include "lo_style.h"
#include "hotreload/ComponentCreatorEngine.h"
#include "user_controller.h"
#include "flights_controller.h"
#include "aircrafts_controller.h"
#include "pixmap_provider.h"
#include "server_connection_checker.h"
#include "request_constants.h"

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

    // PixmapProvider *pixmapProvider = &PixmapProvider::instance();
    // qmlRegisterSingletonInstance("com.letiskoonline.PixmapProvider", 1, 0, "PixmapProvider", pixmapProvider);

    qmlRegisterSingletonType<PixmapProvider>("com.letiskoonline.PixmapImageProvider", 1, 0, "PixmapImageProvider", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject *
                                             {
                                                 Q_UNUSED(engine)
                                                 Q_UNUSED(scriptEngine)

                                                 // Return the PixmapProvider instance
                                                 return static_cast<QObject*>(PixmapProvider::instance()); });

    qmlRegisterType<ServerConnectionChecker>("com.letiskoonline.ServerConnectionChecker", 1, 0, "ServerConnectionChecker");

    ServerConnectionChecker *serverConnectionChecker = new ServerConnectionChecker(RequestConstants::SERVER_NETWORK_ADDRESS, RequestConstants::SERVER_PORT);


    UserController *userController = new UserController(&app);
    qmlRegisterSingletonInstance("com.letiskoonline.UserController", 1, 0, "UserController", userController);

    FlightsController *flightsController = userController->getFlightsController();
    qmlRegisterSingletonInstance("com.letiskoonline.FlightsController", 1, 0, "FlightsController", flightsController);

    AircraftsController *aircraftsController = userController->getAircraftsController();
    qmlRegisterSingletonInstance("com.letiskoonline.AircraftsController", 1, 0, "AircraftsController", aircraftsController);

    // Create and populate list model instance
    // FlightsController listModel;
    // listModel.addFlight("callsign0", "planeName0", 0, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("callsign1", "planeName1", 1, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("callswrewign2", "planeName2", 2, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("callsign3", "planeName3", 3, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("LPFEW", "hornet", 4, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("RTGFD4", "omega", 5, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("callsign6", "planeName6", 6, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("J34JKO", "alfa", 7, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("callsign8", "planeName8", 8, QDateTime::currentDateTime(), QDateTime::currentDateTime());
    // listModel.addFlight("callsign9", "jango", 9, QDateTime::currentDateTime(), QDateTime::currentDateTime());

    // Write out the least elements

    // for (int i = 0; i < listModel.rowCount(); i++)
    // {
    //     // FlightInfo flightInfo = listModel.data(i);
    //     qDebug() << "Flight details at index " << i << ":";
    //     qDebug() << "Callsign: " << listModel.data(listModel.index(i, 0), Roles::CallsignRole);
    //     qDebug() << "Plane Name: " << listModel.data(listModel.index(i, 0), Roles::PlaneNameRole);
    //     qDebug() << "Flight Number: " << listModel.data(listModel.index(i, 0), Roles::FlightStatusRole);
    //     qDebug() << "Departure Time: " << listModel.data(listModel.index(i, 0), Roles::DepartureTimeRole);
    //     qDebug() << "Arrival Time: " << listModel.data(listModel.index(i, 0), Roles::ArrivalTimeRole);
    // }
    // Create filter model
    // FlightFilterProxyModel filterModel;
    // filterModel.setSourceModel(&listModel);
    // filterModel.setFilterRole(Roles::CallsignRole);
    // filterModel.setFilterRole(Roles::PlaneNameRole);
    // filterModel.setFilterRole(Roles::FlightStatusRole);
    // filterModel.setFilterRole(Roles::DepartureTimeRole);
    // filterModel.setFilterRole(Roles::ArrivalTimeRole);
    // filterModel.setSortRole(Roles::CallsignRole);

    QTranslator translator;
    translator.load("slovak.qm");
    app.installTranslator(&translator);

    // Is needed for Settings
    app.setOrganizationName("Letisko online");
    app.setOrganizationDomain("letisko.online");
    app.setApplicationName("Letisko online");

    // qmlRegisterType<Login>("com.login", 1, 0, "Login");
    // qmlRegisterType<UserController>("UserController", 1, 0, "UserController");
    const QUrl url(qgetenv("MAIN_QML"));
    InstallDefaultFont();

    /** << for using with hotreload**/
    ComponentCreatorEngine engine;
    engine.rootContext()->setContextProperty("QmlEngine", &engine);
    /** >> end of source code for hot reload*/

    /** << for testing without hotreload**/
    // QQmlApplicationEngine engine;
    /** >> for testing without hotreload**/

    // qDebug() << "PixmapProvider::instance()->getPixmapProviderName():  " << PixmapProvider::instance()->getPixmapProviderName();
    engine.addImageProvider(QLatin1String(PixmapProvider::instance()->getPixmapProviderName().toLatin1()), PixmapProvider::instance());

    LOStyle *style = new LOStyle(&engine);
    QQmlContext *rootContext = engine.rootContext();
    rootContext->setContextProperty("__style", style);

    FlightsFilterProxyModel *flightsFilterProxyModel = userController->getFlightsController()->getFlightsModel()->getFilterProxyModel();
    rootContext->setContextProperty("flightsFilterProxyModel", flightsFilterProxyModel);

    AircraftsFilterProxyModel *aircraftsFilterProxyModel = userController->getAircraftsController()->getAircraftsModel()->getFilterProxyModel();
    rootContext->setContextProperty("aircraftsFilterProxyModel", aircraftsFilterProxyModel);

    rootContext->setContextProperty("serverConnectionChecker", serverConnectionChecker);
    // rootContext->setContextProperty("pixmapImageProvider", PixmapProvider::instance());

    /** << for using with hotreload**/
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl)
        { if (!obj && url == objUrl) QCoreApplication::exit(- 1); }, Qt::QueuedConnection);
    engine.load(url);
    /** >> end of source code for hot reload*/

    /** << for testing without hotreload**/
    // QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
    //     &app, []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);
    // engine.loadFromModule("OnlineLetiskoMobileApp", "Main");
    /** >> end for testing without hotreload**/

    return app.exec();
}

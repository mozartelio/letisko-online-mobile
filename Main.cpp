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
#include <QFontDatabase>
#include <QtQml/qqmlextensionplugin.h>

#include "cpp/lo_style.h"
#include "hotreload/ComponentCreatorEngine.h"
#include "cpp/user_controller.h"
#include "cpp/flight/flights_controller.h"
#include "cpp/aircraft/aircrafts_controller.h"
#include "cpp/pixmap_provider.h"
#include "cpp/server_connection_checker.h"
#include "cpp/constants.h"
#include "cpp/language_manager.h"
#include "cpp/flight/flights_roles.h"
#include "cpp/flight/flight_request_status.h"

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

    QGuiApplication app(argc, argv);

    qmlRegisterType<LanguageManager>("com.letiskoonline.LanguageManager", 1, 0, "LanguageManager");
    qmlRegisterType<FlightsRoles>("com.letiskoonline.FlightsRoles", 1, 0, "FlightsRoles");
    qmlRegisterType<FlightRequestStatus>("com.letiskoonline.FlightRequestStatus", 1, 0, "FlightRequestStatus");

    qmlRegisterSingletonType(QUrl("qrc:/UserAppSettings.qml"), "UserAppSettings", 1, 0, "UserAppSettings");

    qmlRegisterSingletonType<PixmapProvider>("com.letiskoonline.PixmapImageProvider", 1, 0, "PixmapImageProvider", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject *
                                             {
                                                 Q_UNUSED(engine)
                                                 Q_UNUSED(scriptEngine)

                                                 // Return the PixmapProvider instance
                                                 return static_cast<QObject*>(PixmapProvider::instance()); });

    ServerConnectionChecker *serverConnectionChecker = new ServerConnectionChecker(RequestConstants::SERVER_NETWORK_ADDRESS, RequestConstants::SERVER_PORT, &app);

    qmlRegisterSingletonType<ServerConnectionChecker>("com.letiskoonline.ServerConnectionChecker", 1, 0, "ServerConnectionChecker", [serverConnectionChecker](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject *
                                                      {
                                                          Q_UNUSED(engine)
                                                          Q_UNUSED(scriptEngine)
                                                          return serverConnectionChecker; });

    FlightRequestStatus *flightRequestStatus = FlightRequestStatus::instance();
    qmlRegisterSingletonType<FlightRequestStatus>("com.example", 1, 0, "FlightRequestStatus",
                                                  [flightRequestStatus](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject *
                                                  {
                                                      Q_UNUSED(engine)
                                                      Q_UNUSED(scriptEngine)
                                                      return flightRequestStatus;
                                                  });

    UserController *userController = new UserController(&app);
    qmlRegisterSingletonInstance("com.letiskoonline.UserController", 1, 0, "UserController", userController);

    FlightsController *flightsController = userController->getFlightsController();
    qmlRegisterSingletonInstance("com.letiskoonline.FlightsController", 1, 0, "FlightsController", flightsController);

    AircraftsController *aircraftsController = userController->getAircraftsController();
    qmlRegisterSingletonInstance("com.letiskoonline.AircraftsController", 1, 0, "AircraftsController", aircraftsController);

    // Is needed for QML Settings
    app.setOrganizationName("Letisko online");
    app.setOrganizationDomain("letisko.online");
    app.setApplicationName("Letisko online");

    const QUrl url(qgetenv("MAIN_QML"));
    InstallDefaultFont();

    /** << for using with hotreload
     * from here and until the corresponding ending comment code for hot reload was taken from
     * https://github.com/MarkoStanojevic12/ComponentLibrary/tree/Lesson_01_LiveLoader/ComponentCreator
     **/
    // ComponentCreatorEngine engine;
    // engine.rootContext()->setContextProperty("QmlEngine", &engine);
    /** >> end of source code for hot reload*/

    /** << for testing without hotreload**/
    QQmlApplicationEngine engine;
    /** >> for testing without hotreload**/

    engine.addImageProvider(QLatin1String(PixmapProvider::instance()->getPixmapProviderName().toLatin1()), PixmapProvider::instance());

    LOStyle *style = new LOStyle(&engine);
    QQmlContext *rootContext = engine.rootContext();
    rootContext->setContextProperty("__style", style);

    FlightsFilterProxyModel *flightsFilterProxyModel = userController->getFlightsController()->getFlightsModel()->getFilterProxyModel();
    rootContext->setContextProperty("flightsFilterProxyModel", flightsFilterProxyModel);

    AircraftsFilterProxyModel *aircraftsFilterProxyModel = userController->getAircraftsController()->getAircraftsModel()->getFilterProxyModel();
    rootContext->setContextProperty("aircraftsFilterProxyModel", aircraftsFilterProxyModel);

    LanguageManager *languageManager = new LanguageManager(&app, &engine, &app);
    rootContext->setContextProperty("languageManager", languageManager);

    rootContext->setContextProperty("flightRequestStatus", flightRequestStatus);

    /** << for using with hotreload,
     * from here and until the corresponding ending comment code for hot reload was taken from
      https://github.com/MarkoStanojevic12/ComponentLibrary/tree/Lesson_01_LiveLoader/ComponentCreator
    **/
    // QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl)
    //     { if (!obj && url == objUrl) QCoreApplication::exit(- 1); }, Qt::QueuedConnection);
    // engine.load(url);
    /** >> end of source code for hot reload*/

    /** << for testing without hotreload**/
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app, []()
                     { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.loadFromModule("OnlineLetiskoMobileApp", "Main");
    /** >> end for testing without hotreload**/

    return app.exec();
}

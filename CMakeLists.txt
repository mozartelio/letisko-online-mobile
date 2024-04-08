cmake_minimum_required(VERSION 3.16)

project(OnlineLetiskoMobileApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "C:/Other_programs/Qt/6.6.0/mingw_64/lib/cmake" ${CMAKE_PREFIX_PATH})

find_package(Qt6 REQUIRED COMPONENTS Quick Network LinguistTools)

# qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ./assets/translations/slovak.ts)
#do not work due to recursion
# configure_file(${QM_FILES} ${CMAKE_SOURCE_DIR} COPYONLY)

qt_standard_project_setup(REQUIRES 6.6)

set(CMAKE_AUTORCC ON)

qt_add_executable(appOnlineLetiskoMobileApp
    main.cpp
    ${QM_FILES}
        aircraft_categories_controller.h
)


set_source_files_properties(qml/UserAppSettings.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)


qt_add_qml_module(appOnlineLetiskoMobileApp
    URI OnlineLetiskoMobileApp
    VERSION 1.0
    QML_FILES

    qml/Main.qml
    qml/MainWindow.qml
    qml/UserAppSettings.qml

    #Screens
    qml/screens/LoginScreen.qml
    qml/screens/RegistrationScreen.qml
    qml/screens/SettingsScreen.qml
    qml/screens/FlightsScreen.qml
    qml/screens/DocumentationScreen.qml
    qml/screens/AircraftsScreen.qml

    #Components
    qml/components/PasswordField.qml
    qml/components/EmailTextField.qml
    qml/components/Logo.qml
    qml/components/DrawerItem.qml
    qml/components/SearchBar.qml
    qml/components/FlightStrip.qml
    qml/components/FlightStatus.qml
    qml/components/SortingButton.qml
    qml/components/FlightFilterPopUp.qml
    qml/components/MaterialButton.qml
    qml/components/SortingBar.qml
    qml/components/DocumentationStrip.qml
    qml/components/AircraftStrip.qml
    qml/components/SettingStrip.qml
    qml/components/RoundedImage.qml
    qml/components/divider/HorizontalDividerSubhead.qml
    qml/components/PopupParent.qml
    qml/components/PopupBusyIndicator.qml

    # text font styles
    #Headline
    qml/components/typography/headline/text/HeadlineMediumText.qml
    qml/components/typography/headline/text/HeadlineSmallText.qml
    #Label
    qml/components/typography/label/text/LabelLargeProminentText.qml
    qml/components/typography/label/text/LabelLargeText.qml
    #Title
    qml/components/typography/title/text/TitleSmallText.qml
    qml/components/typography/title/text/TitleLargeText.qml
    qml/components/typography/title/text/TitleMediumText.qml
    #Body
    qml/components/typography/body/text/BodyLargeText.qml
    qml/components/typography/body/text/BodyMediumText.qml
    qml/components/typography/body/text/BodySmallText.qml
    #Display
    qml/components/typography/display/text/DisplaySmallText.qml

    # text input font styles
    #Body
    qml/components/typography/body/input/BodyLargeInput.qml

    RESOURCES
    assets/icons/icons.qrc
    assets/images/images.qrc
    qml/configurations.qrc
    assets/fonts/fonts.qrc

    # slovak.qm
    assets/translations/slovak.ts

    SOURCES
    login.h login.cpp
    user_controller.h user_controller.cpp
    hotreload/FileWatcher.h hotreload/FileWatcher.cpp
    hotreload/ComponentCreatorEngine.h hotreload/ComponentCreatorEngine.cpp
    lostyle.h
    flights_controller.h flights_controller.cpp
    flights_filter_proxy_model.h flights_filter_proxy_model.cpp
    flight_info.h flight_info.cpp
    flights_roles.h
    aircraft_categories_controller.h aircraft_categories_controller.cpp
    request_constants.h request_constants.cpp
    flights_model.h flights_model.cpp
    server_sent_events_parser.h server_sent_events_parser.cpp
    aircrafts_controller.h aircrafts_controller.cpp
    aircrafts_model.h aircrafts_model.cpp
    aircraft_info.h aircraft_info.cpp
    aircrafts_filter_proxy_model.h aircrafts_filter_proxy_model.cpp
    aircrafts_roles.h
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appOnlineLetiskoMobileApp PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appOnlineLetiskoMobileApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    # QML_IMPORT_PATH "${MY_QML_IMPORT_PATH}"
)

target_link_libraries(appOnlineLetiskoMobileApp
    PRIVATE Qt6::Quick
    # PRIVATE UserAppSettingsPlugin
)

include(GNUInstallDirs)
install(TARGETS appOnlineLetiskoMobileApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

#does it WORK?
# qt_add_lupdate(appOnlineLetiskoMobileApp TS_FILES ./assets/translations/slovak.ts)
# add_dependencies(appOnlineLetiskoMobileApp update_translations) # equivalent of all {target}_lupdate

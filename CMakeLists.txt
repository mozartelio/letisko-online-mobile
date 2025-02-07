cmake_minimum_required(VERSION 3.16)

project(OnlineLetiskoMobileApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "C:/Other_programs/Qt/6.6.0/mingw_64/lib/cmake" ${CMAKE_PREFIX_PATH})


find_package(Qt6 REQUIRED COMPONENTS Quick Network LinguistTools)

qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ./assets/translations/sk_SK.ts)

# do not work due to recursion
# configure_file(${QM_FILES} ${CMAKE_SOURCE_DIR} COPYONLY)

qt_standard_project_setup(REQUIRES 6.6)

set(CMAKE_AUTORCC ON)


qt_add_executable(appOnlineLetiskoMobileApp
    main.cpp
    ${QM_FILES}
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
    qml/screens/RegistrationDetailsScreen.qml

    #Components
    qml/components/PasswordField.qml
    qml/components/EmailTextField.qml
    qml/components/Logo.qml
    qml/components/DrawerItem.qml
    qml/components/SearchBar.qml
    qml/components/FlightStrip.qml
    qml/components/FlightStatusChip.qml
    qml/components/SortingButton.qml
    qml/components/FlightFilterPopUp.qml
    qml/components/MaterialButton.qml
    qml/components/DocumentationStrip.qml
    qml/components/AircraftStrip.qml
    qml/components/SettingStrip.qml
    qml/components/RoundedImage.qml
    qml/components/PopupParent.qml
    qml/components/PopupBusyIndicator.qml
    qml/components/ServerConnectionProblem.qml
    qml/components/SortingSection.qml
    qml/components/FlightsSortingBar.qml
    qml/components/FligthStatusCombobox.qml
    qml/components/PasswordRequirements.qml

    # text font styles
    #Headline
    qml/components/typography/headline/text/HeadlineSmallText.qml
    qml/components/typography/headline/text/HeadlineMediumText.qml
    qml/components/typography/headline/text/HeadlineLargeText.qml
    #Label
    qml/components/typography/label/text/LabelLargeProminentText.qml
    qml/components/typography/label/text/LabelLargeText.qml
    #Title
    qml/components/typography/title/text/TitleSmallText.qml
    qml/components/typography/title/text/TitleLargeText.qml
    qml/components/typography/title/text/TitleMediumText.qml
    #Body
    qml/components/typography/body/text/BodySmallText.qml
    qml/components/typography/body/text/BodyMediumText.qml
    qml/components/typography/body/text/BodyLargeText.qml
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
    assets/translations/translations.qrc


    SOURCES
    hotreload/FileWatcher.h hotreload/FileWatcher.cpp
    hotreload/ComponentCreatorEngine.h hotreload/ComponentCreatorEngine.cpp
    
    cpp/user_controller.h cpp/user_controller.cpp

    cpp/lo_style.h
    cpp/constants.h cpp/constants.cpp
    
    cpp/flight/flights_controller.h cpp/flight/flights_controller.cpp
    cpp/flight/flights_filter_proxy_model.h cpp/flight/flights_filter_proxy_model.cpp
    cpp/flight/flight_info.h cpp/flight/flight_info.cpp
    cpp/flight/flights_roles.h
    cpp/flight/flights_model.h cpp/flight/flights_model.cpp
    cpp/flight/flight_request_status.h cpp/flight/flight_request_status.cpp
    
    
    cpp/aircraft/aircrafts_controller.h cpp/aircraft/aircrafts_controller.cpp
    cpp/aircraft/aircrafts_model.h cpp/aircraft/aircrafts_model.cpp
    cpp/aircraft/aircraft_info.h cpp/aircraft/aircraft_info.cpp
    cpp/aircraft/aircrafts_filter_proxy_model.h cpp/aircraft/aircrafts_filter_proxy_model.cpp
    cpp/aircraft/aircrafts_roles.h
    
    cpp/user/personal_info.h cpp/user/personal_info.cpp
    cpp/user/address.h cpp/user/address.cpp
    cpp/user/user.h cpp/user/user.cpp
    
    cpp/server_sent_events_parser.h cpp/server_sent_events_parser.cpp
    cpp/pixmap_provider.h cpp/pixmap_provider.cpp
    cpp/server_connection_checker.h cpp/server_connection_checker.cpp
    cpp/language_manager.h cpp/language_manager.cpp
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
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
    # QML_IMPORT_PATH "${MY_QML_IMPORT_PATH}"
)

target_link_libraries(appOnlineLetiskoMobileApp
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appOnlineLetiskoMobileApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

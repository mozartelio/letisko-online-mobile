cmake_minimum_required(VERSION 3.16)

project(OnlineLetiskoMobileApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QML_IMPORT_PATH "/qml/components/colors/"  CACHE STRING "" FORCE)

find_package(Qt6 5 REQUIRED COMPONENTS Quick Network)
# find_package(Qt6 6 REQUIRED COMPONENTS Quick Network LinguistTools)
#target_link_libraries(mytarget PRIVATE Qt6::Network)
# qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR}/translations/ ${CMAKE_SOURCE_DIR}/translations/slovak.ts)
# qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} slovak.ts)
# configure_file(${QM_FILES} ${CMAKE_SOURCE_DIR}/translations/ COPYONLY)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appOnlineLetiskoMobileApp
    main.cpp
    # ${QM_FILES}
)


# add_library(
#     # SHARED
#     ${QM_FILES}
# )

qt_add_qml_module(appOnlineLetiskoMobileApp
    URI OnlineLetiskoMobileApp
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/screens/LoginScreen.qml
        qml/screens/RegistrationScreen.qml
        qml/screens/MainScreen.qml
        qml/screens/FillProfileDetails.qml
        qml/screens/Flights.qml
        qml/components/PasswordField.qml
        qml/components/Logo.qml
        qml/components/MainScreenModule.qml
        qml/components/DrawerItem.qml
        qml/components/SearchBar.qml
        qml/components/FlightStrip.qml
        qml/components/FlightStatus.qml

        # font styles
        qml/components/typography/headline/text/HeadlineMediumText.qml
        qml/components/typography/label/text/LabelLargeProminentText.qml
        qml/components/typography/label/text/LabelLarge.qml
        qml/components/typography/title/text/TitleLargeText.qml
        qml/components/typography/body/text/BodyLargeText.qml
        qml/components/typography/body/text/BodyMediumText.qml

        qml/components/typography/body/input/BodyLargeInput.qml
        # qml/components/colors/ColorsLight.qml
        # qml/components/colors/sys/colors.js

        qml/components/divider/HorizontalDividerSubhead.qml
        qml/components/ListItem.qml
        qml/MainWindow.qml

    RESOURCES
        assets/LetiskoLogo.svg

        assets/icons/visibility_on.svg
        assets/icons/visibility_off.svg
        assets/icons/home.svg
        assets/icons/aircrafts.svg
        assets/icons/flight_scheduler.svg
        assets/icons/flights.svg
        assets/icons/users.svg
        assets/icons/airport.svg
        assets/icons/documentation.svg
        assets/icons/duties.svg
        assets/icons/licences.svg
        assets/icons/settings.svg
        assets/icons/menu-24px.svg
        assets/icons/search-24px.svg
        assets/icons/close-24px.svg
        assets/icons/more-24px.svg
        assets/icons/check_small-24px.svg
        assets/icons/arrow_right_40px.svg
        assets/icons/3d_avatar_21.png

        assets/fonts/Roboto-Regular.ttf
    SOURCES
        login.h login.cpp
        user.h user.cpp
        hotreload/FileWatcher.h hotreload/FileWatcher.cpp
        hotreload/ComponentCreatorEngine.h hotreload/ComponentCreatorEngine.cpp
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
)

include(GNUInstallDirs)
install(TARGETS appOnlineLetiskoMobileApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

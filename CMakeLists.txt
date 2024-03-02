cmake_minimum_required(VERSION 3.16)

project(OnlineLetiskoMobileApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6 REQUIRED COMPONENTS Quick Network)
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
        qml/components/PasswordField.qml
        qml/components/Logo.qml
        qml/components/MainScreenModule.qml
        qml/components/DrawerItem.qml

        qml/components/typography/headline/HeadlineMedium.qml
        qml/components/typography/label/LabelLargeProminent.qml
    RESOURCES
        assets/icons/visibility_on.svg
        assets/icons/visibility_off.svg
        assets/LetiskoLogo.svg
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
    SOURCES
        login.h login.cpp
        user.h user.cpp
        # hotreload.h hotreload.cpp
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

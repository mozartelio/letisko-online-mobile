cmake_minimum_required(VERSION 3.16)

project(OnlineLetiskoMobileApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
find_package(Qt6 6.5 REQUIRED COMPONENTS Network)
#target_link_libraries(mytarget PRIVATE Qt6::Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appOnlineLetiskoMobileApp
    main.cpp
)

qt_add_qml_module(appOnlineLetiskoMobileApp
    URI OnlineLetiskoMobileApp
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/screens/LoginScreen.qml
        qml/screens/RegistrationScreen.qml
        qml/screens/MainScreen.qml
        qml/components/PasswordField.qml
        qml/components/Logo.qml
    RESOURCES
        assets/icons/visibility_on.svg
        assets/icons/visibility_off.svg
        assets/LetiskoLogo.png
    SOURCES
        login.h
        login.cpp
        user.h
        user.cpp
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

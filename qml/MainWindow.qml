import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.letiskoonline.UserController
import com.letiskoonline.PixmapImageProvider
import "./screens"
import "./components"
import "./components/typography/headline/text"
import "./components/typography/title/text"

Item {
    anchors.fill: parent

    // header: move this to Main.qml as a ApplicationWindow header if not using hot reload
    Column {
        anchors.fill: parent
        ToolBar {
            id: toolBar
            height: __style.toolbarHeight
            position: ToolBar.Header
            width: parent.width
            visible: privates.isNavigationAvailable
            enabled: privates.isNavigationAvailable
            RowLayout {
                anchors {
                    right: parent.right
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                spacing: 0
                ToolButton {
                    id: menuButton
                    Layout.alignment: Qt.AlignVCenter
                    icon.source: __style.menuIcon
                    onClicked: drawer.open()
                }
                Item {
                    Layout.fillWidth: true
                    Label {
                        verticalAlignment: Qt.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                        HeadlineMediumText {
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr(privates.drawerPageName)
                            color: __style.onPrimaryColor
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true

                    ServerConnectionProblem {
                        anchors.centerIn: parent
                        height: 50
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    ToolButton {
                        id: profileButton
                        display: AbstractButton.TextBesideIcon
                        width: implicitWidth
                        height: parent.height
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                            rightMargin: 20
                            leftMargin: 20
                        }

                        contentItem: RowLayout {
                            id: row
                            spacing: 15

                            RoundedImage {
                                id: userPhoto
                                imageSource: if (UserController.user.isAvatarPresent(
                                                         )) {
                                                 return "image://" + "pixmap_images" + "/" + UserController.user.avatarPixmapProviderId
                                             } else {
                                                 __style.userDefaultAvatar
                                             }
                                imageWidth: __style.icon45
                                imageHeight: __style.icon45
                                width: __style.icon45
                                height: __style.icon45
                                Layout.alignment: Qt.AlignVCenter
                            }

                            TitleLargeText {
                                id: userNameSurname
                                width: contentWidth
                                text: if (UserController.user.personalInfo !== null) {
                                          UserController.user.personalInfo.name
                                                  + " " + UserController.user.personalInfo.surname
                                      } else {
                                          ""
                                      }

                                color: __style.onPrimaryColor
                                horizontalAlignment: Text.AlignHCenter
                                wrapMode: Text.WordWrap
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }
                        onClicked: {
                            privates.drawerPageName = "Settings"
                            stackView.replace(settingsScreen)
                        }
                    }
                }
            }
        }

        StackView {
            id: stackView
            initialItem: UserController.isUserLoggedIn(
                             ) ? flightsScreen : loginScreen
            width: parent.width
            height: parent.height
            // anchors.fill: parent  // activate this if not using hot reload
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        visible: false
        enabled: privates.isNavigationAvailable
        interactive: privates.isNavigationAvailable
        background: Rectangle {
            color: __style.surfaceContainerLowColor
            radius: 16
        }

        Column {
            anchors {
                margins: 12
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: 0

            // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
            Rectangle {
                id: airportNameBox
                height: 56
                width: parent.width
                color: drawer.background.color
                HeadlineMediumText {
                    id: airportName
                    text: qsTr("Your airport")
                    anchors {
                        topMargin: 8
                        bottomMargin: airportName.topMargin
                        rightMargin: airportName.topMargin
                        leftMargin: 16
                        fill: parent
                    }
                }
            }

            DrawerItem {
                iconSource: __style.airportIcon
                itemName: "Airport"
                color: stackView.currentItem.objectName
                       === "airportScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                isActive: false
                // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                // onDrawerItemPressed: {
                //     privates.drawerPageName = itemName
                //     drawer.close()
                // }
            }

            DrawerItem {
                id: item
                iconSource: __style.documentationIcon
                itemName: "Documentation"
                color: stackView.currentItem.objectName
                       === "documentationScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                isActive: false
                // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                // onDrawerItemPressed: {
                //     privates.drawerPageName = itemName
                //     stackView.replace(documentationScreen)
                //     drawer.close()
                // }
            }

            DrawerItem {
                iconSource: __style.planeIcon
                itemName: "Aircrafts"
                color: stackView.currentItem.objectName
                       === "aircraftsScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    stackView.replace(aircraftsScreen)
                    drawer.close()
                }
            }

            DrawerItem {
                iconSource: __style.flightsIcon
                itemName: "Flights"
                color: stackView.currentItem.objectName
                       === "flightsScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    stackView.replace(flightsScreen)
                    drawer.close()
                }
            }

            DrawerItem {
                iconSource: __style.settinsIcon
                itemName: "Settings"
                color: stackView.currentItem.objectName
                       === "settingsScreenObject" ? __style.secondaryContainerColor : __style.transparentColor

                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    stackView.replace(settingsScreen)
                    drawer.close()
                }
            }

            // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
            // DrawerItem {
            //     iconSource: "../../assets/icons/users.svg"
            //     itemName:"Users")
            // }
            // DrawerItem {
            //     iconSource: "../../assets/icons/flight_scheduler.svg"
            //     itemName:"Flight scheduler")
            // }

            // DrawerItem {
            //     iconSource: "../../assets/icons/duties.svg"
            //     itemName:"Duties")
            // }

            // DrawerItem {
            //     iconSource: "../../assets/icons/licences.svg"
            //     itemName:"Licences")
            // }
        }
    }

    Component {
        id: loginScreen
        LoginScreen {
            objectName: "loginScreenObject"
            onGoToRegistrationScreen: stackView.replace(registrationScreen)
            onGoToMainScreen: stackView.replace(privates.mainScreenId)
        }
    }

    Component {
        id: registrationScreen
        RegistrationScreen {
            objectName: "registrationScreenObject"
            onGoToLoginScreen: stackView.replace(loginScreen)
            onGoToRegistrationDetailsScreen: stackView.replace(
                                                 registrationDetailsScreen)
        }
    }
    Component {
        id: registrationDetailsScreen
        RegistrationDetailsScreen {
            objectName: "registrationDetailsScreenObject"
            onGoToMainScreen: stackView.replace(privates.mainScreenId)
        }
    }

    Component {
        id: flightsScreen
        FlightsScreen {
            objectName: "flightsScreenObject"
        }
    }

    Component {
        id: aircraftsScreen
        AircraftsScreen {
            objectName: "aircraftsScreenObject"
        }
    }

    Component {
        id: settingsScreen
        SettingsScreen {
            objectName: "settingsScreenObject"
            onLogout: {
                stackView.replace(loginScreen)
            }
        }
    }

    Component {
        id: documentationScreen
        DocumentationScreen {
            objectName: "documentationScreenObject"
        }
    }

    Connections {
        target: UserController.user

        function onPersonalInfoChanged(personalinfo) {
            if (personalinfo === true) {
                userNameSurname.text = UserController.user.personalInfo.name
                        + " " + UserController.user.personalInfo.surname
            }
        }

        function onAvatarPixmapProviderIdChanged() {
            userPhoto.imageSource = "image://" + "pixmap_images" + "/"
                    + UserController.user.avatarPixmapProviderId
        }
    }

    Connections {
        target: UserController

        function profileDetailsFilledInResult(personalinfo) {
            if (personalinfo === true) {
                userNameSurname.text = UserController.user.personalInfo.name
                        + " " + UserController.user.personalInfo.surname
            }
        }
    }
    QtObject {
        id: privates

        property var mainScreenId: flightsScreen

        property string drawerPageName: "Flights" //default
        property bool isNavigationAvailable: stackView.currentItem.objectName
                                             !== "loginScreenObject"
                                             && stackView.currentItem.objectName
                                             !== "registrationScreenObject"
                                             && stackView.currentItem.objectName
                                             !== "registrationDetailsScreenObject"
    }
}

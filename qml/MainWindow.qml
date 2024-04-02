import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.letiskoonline.UserController
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
                    fill: parent
                    right: parent.right
                    left: parent.left
                }
                spacing: 0
                ToolButton {
                    id: menuButton
                    Layout.alignment: Qt.AlignVCenter
                    icon.source: __style.menuIcon
                    onClicked: drawer.open()
                }
                Label {
                    // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter | Qt.AnchorCenter
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    HeadlineMediumText {
                        anchors.verticalCenter: parent.verticalCenter
                        // anchors.centerIn: parent
                        text: privates.drawerPageName
                        color: __style.onPrimaryColor
                    }
                }

                ToolButton {
                    id: control
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    display: AbstractButton.TextBesideIcon

                    contentItem: RowLayout {
                        id: row
                        spacing: 15

                        RoundedImage {
                            id: userPhoto
                            imageSource: "../../assets/icons/3d_avatar_21.png"
                            imageWidth: __style.icon45
                            imageHeight: __style.icon45
                            width: __style.icon45
                            height: __style.icon45
                            Layout.alignment: Qt.AlignVCenter
                        }

                        TitleLargeText {
                            id: userNameSurname
                            width: contentWidth
                            text: "Name Surname"
                            color: __style.onPrimaryColor
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }
                    onClicked: {
                        privates.drawerPageName = qsTr("Settings");
                        stackView.replace(settingsScreen);
                        console.log("here is a profile...");
                    }
                }
            }
        }

        StackView {
            id: stackView
            initialItem: flightsScreen//loginScreen // // //aircraftsScreen // //settingsScreen // // // //documentationScreen
            width: parent.width
            height: parent.height
            // anchors.fill: parent  // activate this if not using hot reload
            onCurrentItemChanged: {
                console.log("Current Item:", stackView.currentItem, "Stack depth:", stackView.depth);
            }
            // do not use becouse the start is from the login or registrsation page, where topbar is disabled
            // Component.onCompleted: privates.drawerPageName = qsTr(
            //                            "Documentation")
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

            Rectangle {
                id: airportNameBox
                height: 56
                width: parent.width
                color: drawer.background.color
                HeadlineMediumText {
                    id: airportName
                    text: qsTr("Kosice airport")
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
                itemName: qsTr("Airport")
                color: stackView.currentItem.objectName === "airportScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName;
                    drawer.close();
                }
            }

            DrawerItem {
                id: item
                iconSource: __style.documentationIcon
                itemName: qsTr("Documentation")
                color: stackView.currentItem.objectName === "documentationScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName;
                    stackView.replace(documentationScreen);
                    drawer.close();
                }
            }

            DrawerItem {
                iconSource: __style.planeIcon
                itemName: qsTr("Aircrafts")
                color: stackView.currentItem.objectName === "aircraftsScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName;
                    stackView.replace(aircraftsScreen);
                    drawer.close();
                }
            }

            DrawerItem {
                iconSource: __style.flightsIcon
                itemName: qsTr("Flights")
                color: stackView.currentItem.objectName === "flightsScreenObject" ? __style.secondaryContainerColor : __style.transparentColor
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName;
                    stackView.replace(flightsScreen);
                    drawer.close();
                }
            }

            DrawerItem {
                iconSource: __style.settinsIcon
                itemName: qsTr("Settings")
                color: stackView.currentItem.objectName === "settingsScreenObject" ? __style.secondaryContainerColor : __style.transparentColor

                onDrawerItemPressed: {
                    privates.drawerPageName = itemName;
                    stackView.replace(settingsScreen);
                    drawer.close();
                }
            }

            // DrawerItem {
            //     iconSource: "../../assets/icons/home.svg"
            //     itemName: qsTr("Home")
            // }
            // DrawerItem {
            //     iconSource: "../../assets/icons/users.svg"
            //     itemName: qsTr("Users")
            // }
            // DrawerItem {
            //     iconSource: "../../assets/icons/flight_scheduler.svg"
            //     itemName: qsTr("Flight scheduler")
            // }

            // DrawerItem {
            //     iconSource: "../../assets/icons/duties.svg"
            //     itemName: qsTr("Duties")
            // }

            // DrawerItem {
            //     iconSource: "../../assets/icons/licences.svg"
            //     itemName: qsTr("Licences")
            // }

            //TODO:
            // ScrollIndicator.vertical: ScrollIndicator {}
        }
    }

    Component {
        id: loginScreen
        LoginScreen {
            objectName: "loginScreenObject"
            // userController: userId
            onGoToRegistrationScreen: stackView.replace(registrationPage)
            onGoToMainScreen: stackView.replace(flightsScreen)
        }
    }

    Component {
        id: registrationPage
        RegistrationScreen {
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
                stackView.replace(loginScreen);
                console.log("logged out successfully");
            }
        }
    }

    Component {
        id: documentationScreen
        DocumentationScreen {
            objectName: "documentationScreenObject"
        }
    }

    // UserController {
    //     id: userId
    // }

    QtObject {
        id: privates

        property string drawerPageName
        property bool isNavigationAvailable: stackView.currentItem.objectName !== "loginScreenObject"
    }
}

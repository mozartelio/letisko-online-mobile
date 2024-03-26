import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import com.user 1.0
import "./screens"
import "./components"
import "./components/typography/headline/text"
import "./components/typography/title/text"

Item {
    property bool drawerAvailable: false

    anchors.fill: parent

    // header: move this to Main.qml as a ApplicationWindow header if not using hot reload
    Column {
        anchors.fill: parent
        ToolBar {
            id: toolBar
            height: 64
            position: ToolBar.Header
            width: parent.width

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
                    icon.source: "../assets/icons/menu-24px.svg"
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
                        color: "white"
                    }
                }

                ToolButton {
                    id: control
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    display: AbstractButton.TextBesideIcon
                    implicitWidth: userPhoto.implicitWidth + userNameSurname.implicitWidth
                    // implicitHeight: userPhoto.implicitHeigh + userNameSurname.implicitHeigh
                    contentItem: Row {
                        id: row
                        anchors.right: parent.right
                        spacing: 15

                        Image {
                            id: userPhoto
                            anchors.verticalCenter: parent.verticalCenter
                            source: "../assets/icons/3d_avatar_21.png"
                            width: 45
                            height: 45
                            verticalAlignment: Image.AlignVCenter
                        }

                        TitleLargeText {
                            id: userNameSurname
                            anchors.verticalCenter: parent.verticalCenter
                            width: contentWidth
                            text: "Name Surname"
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                        }
                    }
                    onClicked: {
                        console.log("here is a profile...")
                    }
                }
            }
        }

        StackView {
            initialItem: flightsPage //aircraftsPage  //documentationPage
            width: parent.width
            height: parent.height
            id: stackView
            // anchors.fill: parent  // activate this if not using hot reload
            onCurrentItemChanged: {
                console.log("Current Item:", stackView.currentItem)
                // privates.drawerPageName = stackView.currentItem
            }
            Component.onCompleted: privates.drawerPageName = qsTr(
                                       "Documentation")
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        visible: drawerAvailable
        background: Rectangle {
            color: "#F7F2FA" //ColorsLight.surface_container_low
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
                iconSource: "../../assets/icons/airport.svg"
                itemName: qsTr("Airport")
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    drawer.close()
                }
            }

            DrawerItem {
                iconSource: "../../assets/icons/documentation.svg"
                itemName: qsTr("Documentation")
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    stackView.replace(documentationPage)
                    drawer.close()
                }
            }

            DrawerItem {
                iconSource: "../../assets/icons/aircrafts.svg"
                itemName: qsTr("Aircrafts")
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    stackView.replace(aircraftsPage)
                    drawer.close()
                }
            }

            DrawerItem {
                iconSource: "../../assets/icons/flights.svg"
                itemName: qsTr("Flights")
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    stackView.replace(flightsPage)
                    drawer.close()
                }
            }

            DrawerItem {
                iconSource: "../../assets/icons/settings.svg"
                itemName: qsTr("Settings")
                onDrawerItemPressed: {
                    privates.drawerPageName = itemName
                    drawer.close()
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
        id: loginPage
        LoginScreen {
            user: userId
            onGoToRegistrationScreen: stackView.replace(registrationPage)
            onGoToMainScreen: stackView.replace(mainPage)
        }
    }

    Component {
        id: registrationPage
        RegistrationScreen {
            onGoToLoginScreen: stackView.push(loginPage)
            onGoToMainScreen: stackView.replace(mainPage)
        }
    }

    Component {
        id: mainPage
        MainScreen {//            onGoToLoginPage: stackView.push(loginPage)
        }
    }

    Component {
        id: flightsPage
        FlightsScreen {}
    }

    Component {
        id: aircraftsPage
        AircraftsScreen {}
    }

    Component {
        id: documentationPage
        DocumentationScreen {}
    }

    User {
        id: userId
    }

    QtObject {
        id: privates

        property string drawerPageName
    }
}

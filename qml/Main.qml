import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import com.user 1.0
import "./screens"
import "./components"
import "./components/typography/headline"

ApplicationWindow {
    property bool drawerAvailable: true
    id: window

    width: 1194
    height: 834
    visible: true
    title: qsTr("Online letisko")
    color: "white"

    StackView {
        initialItem: loginPage
        width: parent.width
        height: parent.height
        id: stackView
        anchors.fill: parent
        onCurrentItemChanged: console.log("Current Item:",
                                          stackView.currentItem)
    }

    User {
        id: userId
    }

    Drawer {
        id: drawer
        width: 0.33 * window.width
        height: window.height
        visible: drawerAvailable
        background: Rectangle {
            color: "#F7F2FA"
            radius: 16
        }

        ColumnLayout {
            anchors {
                margins: 12
                top: parent.top
                left: parent.left
                right: parent.right
            }
            layoutDirection: Qt.LeftToRight
            spacing: 0

            Rectangle {
                id: airportName
                Layout.preferredHeight: 56
                Layout.minimumHeight: Layout.preferredHeight
                Layout.maximumHeight: Layout.preferredHeight
                Layout.fillWidth: true
                Layout.topMargin: 8
                Layout.bottomMargin: Layout.topMargin
                Layout.rightMargin: Layout.topMargin
                Layout.leftMargin: 16
                color: drawer.background.color
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft | Qt.AnchorLeft | Qt.AnchorTop
                HeadlineMedium {
                    text: qsTr("Kosice airport")
                    verticalAlignment: Text.AlignVCenter
                    anchors {
                        fill: parent
                    }
                }
            }
            DrawerItem {
                iconSource: "../../assets/icons/home.svg"
                itemName: qsTr("Home")
            }

            DrawerItem {
                iconSource: "../../assets/icons/aircrafts.svg"
                itemName: qsTr("Aircrafts")
            }

            DrawerItem {
                iconSource: "../../assets/icons/flight_scheduler.svg"
                itemName: qsTr("Flight scheduler")
            }

            DrawerItem {
                iconSource: "../../assets/icons/flights.svg"
                itemName: qsTr("Flights")
            }

            DrawerItem {
                iconSource: "../../assets/icons/users.svg"
                itemName: qsTr("Users")
            }

            DrawerItem {
                iconSource: "../../assets/icons/airport.svg"
                itemName: qsTr("Airport")
            }

            DrawerItem {
                iconSource: "../../assets/icons/documentation.svg"
                itemName: qsTr("Documentation")
            }

            DrawerItem {
                iconSource: "../../assets/icons/duties.svg"
                itemName: qsTr("Duties")
            }

            DrawerItem {
                iconSource: "../../assets/icons/licences.svg"
                itemName: qsTr("Licences")
            }

            DrawerItem {
                iconSource: "../../assets/icons/settings.svg"
                itemName: qsTr("Settings")
            }
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
}

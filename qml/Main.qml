import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import com.user 1.0
import "./screens"
import "./components"

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
            spacing: 0
            DrawerItem {
                iconSource: "../../assets/icons/home.svg"
                itemName: "Home"
                drawerWidth: drawer.width
            }

            DrawerItem {
                iconSource: "../../assets/icons/aircrafts.svg"
                itemName: "Aircrafts"
                drawerWidth: drawer.width
            }
        }

        // RowLayout {
        //     anchors{
        //         top: parent.top
        //     }
        //     spacing: 6
        //     Rectangle {
        //         color: 'azure'
        //         Layout.preferredWidth: 100
        //         Layout.preferredHeight: 150
        //     }
        //     Rectangle {
        //         color: "plum"
        //         Layout.fillWidth: true
        //         Layout.fillHeight: true
        //     }
        // }
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

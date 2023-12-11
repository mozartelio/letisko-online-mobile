import QtQuick
import QtQuick.Controls 2.15
import com.user 1.0
import "./screens"

ApplicationWindow {
    property bool drawerAvailable: false
    id: window

    width: 370
    height: 580
    visible: true
    title: qsTr("Online letisko")
    color: "darkGray"

    StackView {
        initialItem: registrationPage
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
        width: 0.66 * window.width
        height: window.height
        visible: drawerAvailable

        Label {
            text: "Content goes here!"
            anchors.centerIn: parent
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

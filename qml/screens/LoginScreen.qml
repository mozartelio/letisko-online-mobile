import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
// import com.login 1.0
import com.user 1.0
import "../components/"

Item {
    property string emailValue: ""
    property User user
    property string passwordValue
    signal goToRegistrationScreen
    signal goToMainScreen

    Logo {
        anchors.bottom: textLabel.top
    }

    Text {
        id: textLabel
        text: "LOGIN"
        anchors.left: loginFrame.left
        anchors.bottom: loginFrame.top
        anchors.bottomMargin: 10
        font.bold: true
        font.pixelSize: 20
        color: "white"
    }

    Item {
        id: loginFrame

        anchors.centerIn: parent
        width: rect.width
        height: rect.height

        Rectangle {
            id: rect

            anchors.fill: column
            color: "lightGray"
            radius: 20
            border.color: "black"
            border.width: 2
        }

        Column {
            id: column

            spacing: 5
            leftPadding: 20
            topPadding: 20
            rightPadding: 20
            bottomPadding: 20
            Text {
                text: "Email"
            }
            TextField {
                id: email

                width: 200
                height: 30
                color: "black"
                maximumLength: 255
                onTextChanged: emailValue = text

                background: Rectangle {
                    color: "white"
                    radius: 5
                }
            }
            Item {
                height: 15
                width: 1
            }

            Text {
                text: "Heslo"
            }
            PasswordField {
                onTextChanged: passwordValue = text
            }
        }
    }

    Button {
        id: button
        text: "Send"
        anchors.horizontalCenter: loginFrame.horizontalCenter
        anchors.top: loginFrame.bottom
        anchors.topMargin: 10
        onClicked: {
            if (user.doLogin(emailValue, passwordValue)) {
                console.log("logged")
                goToMainScreen()
            }
        }

        background: Rectangle {
            color: "green"
            radius: 10
        }
        leftInset: -6
        rightInset: leftInset

        topInset: -2
        bottomInset: topInset
    }

    Column {
        anchors.top: button.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: notRegistered

            text: "Not yet registered?"
            horizontalAlignment: Text.AlignHCenter
        }
        Text {
            text: "Registration"
            color: "blue"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    goToRegistrationScreen()
                }
            }
        }
    }
}

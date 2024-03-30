import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
// import com.login 1.0
import "../components/"

Item {
    property string emailValue: ""
    property bool showRegistrationPasswords: false
    signal goToLoginScreen
    signal goToMainScreen

    // signal changeShowPasswordFirstField
    // signal changeShowPasswordSecondField
    // Login {
    //     id: loginObject
    // }
    Logo {
        anchors.bottom: textLabel.top
    }

    Text {
        id: textLabel
        text: "REGISTRATION"
        anchors.left: loginFrame.left
        anchors.bottom: loginFrame.top
        anchors.bottomMargin: 10
        font.bold: true
        font.pixelSize: 20
        color: __style.onPrimaryColor
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
            border.color: __style.blackColor
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
                color: __style.blackColor
                maximumLength: 255
                onTextChanged: emailValue = text

                background: Rectangle {
                    color: __style.onPrimaryColor
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

            //TODO: spravit aby stav skrytia hesla sa synchronizoval medzi polickami
            PasswordField {
                onShowPasswordChanged: {
                    showRegistrationPasswords = showPassword
                    // changeShowPasswordSecondField()
                }
            }
            PasswordField {
                // showPassword: showPassword
                onShowPasswordChanged: {
                    showRegistrationPasswords = showPassword
                    // changeShowPasswordFirstField()
                }
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
            goToMainScreen()
        }

        //            loginObject.doLogin(emailValue, passswordValue)
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

            text: "Already registered?"
            horizontalAlignment: Text.AlignHCenter
        }
        Text {
            text: "Login"
            color: "blue"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    goToLoginScreen()
                }
            }
        }
    }
}

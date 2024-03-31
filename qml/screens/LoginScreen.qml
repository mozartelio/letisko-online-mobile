import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import User
import "../components"

Page {
    property string emailValue: ""
    property User user
    property string passwordValue
    signal goToRegistrationScreen
    signal goToMainScreen
    background: Rectangle {
        color: __style.onPrimaryColor
    }
    contentItem: ColumnLayout {
        spacing: 15
        height: parent.height - __style.toolbarHeight
        width: parent.width
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            fill: parent
        }

        Logo {
            Layout.preferredWidth: 270
            Layout.preferredHeight: 150
            Layout.topMargin: 40
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        Text {
            id: textLabel
            text: qsTr("LOGIN")
            font.bold: true
            font.pixelSize: 20
            color: __style.blackColor
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: textLabel.implicitHeight
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            color: __style.pressAccentColor
            radius: 12
            Layout.preferredWidth: column.implicitWidth
            Layout.preferredHeight: column.implicitHeight
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            Column {
                id: column

                spacing: 15
                leftPadding: 20
                topPadding: 20
                rightPadding: 20
                bottomPadding: 20
                Text {
                    text: qsTr("Email")
                }
                EmailTextField {
                    id: email
                    width: 240
                    onTextChanged: emailValue = text
                }

                Text {
                    text: qsTr("Password")
                }
                PasswordField {
                    id: passswordInput
                    width: 240
                    onTextChanged: passwordValue = text
                }

                Button {
                    id: button
                    contentItem: Text {
                        text: qsTr("Send")
                        color: __style.onPrimaryColor
                    }
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    onClicked: {
                        if (user.doLogin(emailValue, passwordValue)) {
                            console.log("logged")
                            goToMainScreen()
                        }
                    }

                    background: Rectangle {
                        color: __style.primaryColor
                        radius: 100
                    }
                    leftInset: -6
                    rightInset: leftInset

                    topInset: -2
                    bottomInset: topInset
                }
            }
        }

        Column {
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: notRegistered.implicitHeight + registration.implicitHeight + 60
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Text {
                id: notRegistered
                text: qsTr("Not yet registered?")
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }
            Text {
                id: registration
                text: qsTr("Registration")
                color: __style.primaryColor
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        goToRegistrationScreen()
                    }
                }
            }
        }
    }
}

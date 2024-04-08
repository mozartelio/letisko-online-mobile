import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import com.letiskoonline.UserController
import "../components"
import "../components/typography/title/text/"

Page {
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
                    id: emailInput
                    width: 240
                }

                Text {
                    text: qsTr("Password")
                }
                PasswordField {
                    id: passswordInput
                    width: 240
                }

                MaterialButton {
                    id: button
                    backgroundColor: __style.primaryColor
                    contentText: qsTr("Send")
                    contentTextColor: __style.onPrimaryColor
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    onClicked: {
                        if (!emailInput.validationRegex.test(emailInput.text)) {
                            infoPopupTextContent.text = privates.loginErrorText + "\n" + qsTr(
                                        "entered value is not a valid email!")
                            infoPopup.open()
                            return
                        }
                        ;
                        if (passswordInput.text.trim() === ""
                                || passswordInput.text === undefined) {
                            infoPopupTextContent.text = privates.loginErrorText + "\n" + qsTr(
                                        "empty password!")
                            infoPopup.open()
                            return
                        }
                        loadingPopup.open()
                        UserController.doLogin(emailInput.text,
                                               passswordInput.text)
                    }
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

    Connections {
        target: UserController

        function onLoginResult(result) {
            if (result === true) {
                // console.log("logged in successfully")
                goToMainScreen()
            } else {
                infoPopupTextContent.text = privates.loginErrorText + "\n" + result
                loadingPopup.close()
                infoPopup.open()
            }
        }
    }

    PopupParent {
        id: infoPopup
        leftButon.visible: false
        rightButton.contentText: qsTr("OK")
        content: TitleMediumText {
            id: infoPopupTextContent
            color: __style.blackColor
            width: parent.width
            height: parent.height
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }

    PopupBusyIndicator {
        id: loadingPopup
    }

    QtObject {
        id: privates
        property string loginErrorText: qsTr("Login failed, the reason is:")
    }
}

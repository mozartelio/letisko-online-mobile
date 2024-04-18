import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import com.letiskoonline.UserController
import "../components"
import "../components/typography/title/text/"
import "../components/typography/label/text/"
import "../components/typography/headline/text/"

Page {
    signal goToRegistrationScreen
    signal goToMainScreen

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    contentItem: ColumnLayout {
        spacing: 15
        height: parent.height
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
            Layout.alignment: Qt.AlignCenter
        }

        ServerConnectionProblem {
            Layout.alignment: Qt.AlignCenter
        }

        HeadlineSmallText {
            id: textLabel
            text: qsTr("LOG IN")
            font.bold: true
            color: __style.blackColor
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: textLabel.implicitHeight
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Column {
            id: column
            spacing: 15
            leftPadding: 20
            rightPadding: 20
            bottomPadding: 20
            Layout.alignment: Qt.AlignCenter

            EmailTextField {
                id: emailInput
                width: 280
            }

            PasswordField {
                id: passswordInput
                width: 280
            }

            MaterialButton {
                id: button
                backgroundColor: __style.primaryColor
                contentText: qsTr("Log in")
                contentTextColor: __style.onPrimaryColor
                enabled: (passswordInput.text.trim() !== ""
                          && passswordInput.text !== undefined)
                         && (emailInput.text.trim() !== ""
                             && emailInput.text !== undefined)
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
                    loadingPopup.open()
                    UserController.doLogin(emailInput.text, passswordInput.text)
                }
            }
        }

        Column {
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: notRegistered.implicitHeight + registration.implicitHeight + 60
            Layout.alignment: Qt.AlignCenter
            TitleMediumText {
                id: notRegistered
                text: qsTr("Not yet registered?")
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }
            TitleMediumText {
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
                loadingPopup.close()
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
        property string loginErrorText: qsTr("Log in procedure failed, the reason is:")
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import com.letiskoonline.UserController
import "../components"
import "../components/typography/body/text/"
import "../components/typography/title/text/"
import "../components/typography/label/text/"
import "../components/typography/headline/text/"

Page {
    signal goToMainScreen
    signal goToLoginScreen

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    contentItem: ScrollView {
        id: scrollView
        height: parent.height
        width: parent.width
        contentWidth: parent.width
        contentHeight: contentColumn.implicitHeight
        anchors {
            fill: parent
        }

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ScrollBar.horizontal.interactive: false
        ScrollBar.vertical.interactive: true

        ColumnLayout {
            id: contentColumn
            spacing: 12
            width: parent.width
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Logo {
                Layout.preferredWidth: 270
                Layout.preferredHeight: 150
                Layout.topMargin: 15
                Layout.alignment: Qt.AlignCenter
            }

            ServerConnectionProblem {
                Layout.alignment: Qt.AlignCenter
            }

            HeadlineSmallText {
                id: textLabel
                text: qsTr("REGISTRATION")
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

                width: parent.Layout.preferredWidth
                spacing: 12
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 20
                Layout.alignment: Qt.AlignCenter

                EmailTextField {
                    id: emailInput
                    width: 240
                    onTextChanged: passwordRequirementsGuard.email = text
                }

                PasswordField {
                    id: passswordInput
                    width: 240
                    onTextChanged: passwordRequirementsGuard.password = text
                }
                PasswordRequirements {
                    id: passwordRequirementsGuard
                    email: emailInput.text
                    password: passswordInput.text
                }

                MaterialButton {
                    id: button
                    backgroundColor: __style.primaryColor
                    contentText: qsTr("Register")
                    enabled: passwordRequirementsGuard.areAllConditionsMet()
                             && (emailInput.text.trim() !== ""
                                 && emailInput.text !== undefined)
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
                        loadingPopup.open()
                        UserController.doLogin(emailInput.text,
                                               passswordInput.text)
                    }
                }
            }

            Column {
                Layout.preferredWidth: parent.width
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: notRegistered.implicitHeight
                                        + registration.implicitHeight + 60
                Layout.alignment: Qt.AlignCenter
                TitleMediumText {
                    id: notRegistered
                    text: qsTr("Already registered?")

                    horizontalAlignment: Text.AlignHCenter
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                TitleMediumText {
                    id: registration
                    text: qsTr("Log in")

                    color: __style.primaryColor
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            goToLoginScreen()
                        }
                    }
                }
            }
        }
    }
    Connections {
        target: UserController
        //todo:
        // function onLoginResult(result) {
        //     if (result === true) {
        //         // console.log("logged in successfully")
        //         goToMainScreen()
        //     } else {
        //         infoPopupTextContent.text = privates.loginErrorText + "\n" + result
        //         loadingPopup.close()
        //         infoPopup.open()
        //     }
        // }
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
        property string loginErrorText: qsTr("Registration failed, the reason is:")
    }
}

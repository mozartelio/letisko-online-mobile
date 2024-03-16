import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
// import com.login 1.0
import com.user 1.0
import "../components/colors/sys"
import "../components"

Page {
    property string emailValue: ""
    property User user
    property string passwordValue
    signal goToRegistrationScreen
    signal goToMainScreen
    background: Rectangle {
        color: "white"
    }
    contentItem: Item {

        Logo {
            anchors.bottom: textLabel.top
            width: 270
            height: 143
        }

        Text {
            id: textLabel
            text: qsTr("LOGIN")
            anchors.left: loginFrame.left
            anchors.bottom: loginFrame.top
            anchors.bottomMargin: 10
            font.bold: true
            font.pixelSize: 20
            color: "black"
        }

        Item {
            id: loginFrame

            anchors.centerIn: parent
            width: rect.width
            height: rect.height

            Rectangle {
                id: rect
                anchors.fill: column
                color: ColorsLight.inverse_primary
                radius: 12
            }

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

                Text {
                    text: "Heslo"
                }
                PasswordField {
                    id: passswordInput
                    onTextChanged: passwordValue = text
                }

                Button {
                    id: button
                    contentItem: Text {
                        text: qsTr("Send")
                        color: "white"
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
                        color: "#6750A4"
                        radius: 100
                    }
                    leftInset: -6
                    rightInset: leftInset

                    topInset: -2
                    bottomInset: topInset
                }
            }
        }
    }
    // TODO:
    // Column {
    //     anchors.top: button.bottom
    //     anchors.horizontalCenter: parent.horizontalCenter

    //     Text {
    //         id: notRegistered

    //         text: "Not yet registered?"
    //         horizontalAlignment: Text.AlignHCenter
    //     }
    //     Text {
    //         text: "Registration"
    //         color: "blue"
    //         font.bold: true
    //         horizontalAlignment: Text.AlignHCenter
    //         MouseArea {
    //             anchors.fill: parent
    //             onClicked: {
    //                 goToRegistrationScreen()
    //             }
    //         }
    //     }
    // }
}

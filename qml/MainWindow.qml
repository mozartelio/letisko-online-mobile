import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import com.user 1.0
import "./screens"
import "./components"
import "./components/typography/headline"
import "./components/typography/title"

Item {
    property bool drawerAvailable: false
    anchors.fill: parent

    // header: move this to Main.qml as a ApplicationWindow header if not using hot reload
    Column {
        anchors.fill: parent
        ToolBar {
            id: toolBar
            height: 64
            position: ToolBar.Header
            width: parent.width

            RowLayout {
                anchors {
                    fill: parent
                    right: parent.right
                    left: parent.left
                }
                spacing: 0
                ToolButton {
                    id: menuButton
                    Layout.alignment: Qt.AlignVCenter | Qt.AnchorLeft
                    icon.source: "../assets/icons/menu-24px.svg"
                    onClicked: drawer.open()
                }
                Label {
                    // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter | Qt.AnchorCenter
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    HeadlineMedium {
                        anchors.verticalCenter: parent.verticalCenter
                        // anchors.centerIn: parent
                        text: qsTr("App")
                        color: "white"
                    }
                }

                ToolButton {
                    id: control
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight | Qt.AnchorRight
                    display: AbstractButton.TextBesideIcon
                    contentItem: Text {
                        id: userNameSurname
                        text: "Name Surname"
                        font.family: "Roboto"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        wrapMode: Text.WordWrap
                    }
                    background: Rectangle {

                        implicitWidth: 175 + 40 + 15
                        implicitHeight: 48
                        color: "transparent"
                        Image {
                            id: userPhoto
                            source: "../assets/icons/3d_avatar_21.png"
                            width: 40
                            height: 40
                            verticalAlignment: Image.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    onClicked: console.log("here is a profile...")
                }

                // ToolButton {
                //     id: control
                //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight | Qt.AnchorRight
                //     contentItem: Text {
                //         text: "control.text"
                //         // font: control.font
                //         opacity: enabled ? 1.0 : 0.3
                //         color: control.down ? "#17a81a" : "#21be2b"
                //         horizontalAlignment: Text.AlignHCenter
                //         verticalAlignment: Text.AlignVCenter
                //         elide: Text.ElideRight
                //     }

                //     background: Rectangle {
                //         implicitWidth: 218
                //         implicitHeight: 48
                //         color: "salmon"

                //         Row {
                //             id: toolBarNameButtonRow
                //             width: 218
                //             height: 48
                //             spacing: 3
                //             anchors {
                //                 verticalCenter: parent.verticalCenter
                //             }

                //             Image {
                //                 id: avatar
                //                 source: "../assets/icons/airport.svg"
                //                 width: 40
                //                 height: 40
                //                 fillMode: Image.PreserveAspectFit
                //             }
                //             TitleLarge {
                //                 width: toolBarNameButtonRow.width - avatar.width
                //                        - toolBarNameButtonRow.spacing
                //                 text: "Name Surname"
                //             }
                //         }
                //         // Qt.darker(
                //         //        "#33333333", control.enabled
                //         //        && (control.checked
                //         //            || control.highlighted) ? 1.5 : 1.0)
                //         // opacity: enabled ? 1 : 0.3
                //         // visible: control.down || (control.enabled
                //         //                           && (control.checked
                //         //                               || control.highlighted))
                //     }
                //     onClicked: console.log("here is a profile...")
                // }
            }
        }
        StackView {
            initialItem: loginPage
            width: parent.width
            height: parent.height
            id: stackView
            // anchors.fill: parent  // activate this if not using hot reload
            onCurrentItemChanged: console.log("Current Item:",
                                              stackView.currentItem)
        }
    }

    User {
        id: userId
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        visible: drawerAvailable
        background: Rectangle {
            color: "#F7F2FA"
            radius: 16
        }

        Column {
            anchors {
                margins: 12
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: 0

            Rectangle {
                id: airportNameBox
                height: 56
                width: parent.width
                color: drawer.background.color
                HeadlineMedium {
                    id: airportName
                    text: qsTr("Kosice airport")
                    anchors {
                        topMargin: 8
                        bottomMargin: airportName.topMargin
                        rightMargin: airportName.topMargin
                        leftMargin: 16
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
            //TODO:
            // ScrollIndicator.vertical: ScrollIndicator {}
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

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import "../components/typography/display/text"
import "../components"

Page {
    id: root

    Material.theme: Material.Light
    background: Rectangle {
        color: "white"
    }

    Rectangle {
        id: settingsBox
        //TODO: responsivity
        width: parent.width / 3
        height: parent.height - anchors.topMargin - anchors.bottomMargin
        color: "#F7F2FA"
        radius: 12
        clip: true
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 16
            bottomMargin: 16
        }

        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: content.implicitHeight + 40
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            ScrollBar.vertical: ScrollBar {
                active: true
                policy: ScrollBar.AlwaysOff
                interactive: true
                orientation: Qt.Vertical
                // z: 2
            }

            ColumnLayout {
                id: content
                width: settingsBox.width
                height: settingsBox.height
                spacing: 0

                MaterialButton {
                    contentText: qsTr("Log out")
                    imagePath: "./../../assets/icons/logout_24px.svg"
                    backgroundColor: "#6750A4"
                    contentTextColor: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.topMargin: 15
                    onClicked: console.log(
                                   parent.height - settingsBox.anchors.topMargin)
                }

                DisplaySmallText {
                    text: qsTr("Personal")
                    Layout.topMargin: 10
                    Layout.bottomMargin: 10
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }
                Column {
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    spacing: 0
                    Rectangle {
                        color: "#49454F"
                        width: parent.width
                        height: 1
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Name Surname"
                        settingTextContent: "John Controxo"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Email"
                        settingTextContent: "controlman@controlman.com"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Phone number"
                        settingTextContent: "053434328324"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Empty
                        settingName: "Adress"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Image
                        settingName: "Photo"
                        settingImageContent: "../../assets/icons/default_plane_plug.png"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Qualification type"
                        settingTextContent: "Night control man"
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Qualification start date"
                        settingTextContent: "01.02.2023"
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Qualification end date"
                        settingTextContent: "01.02.2025"
                        width: parent.width
                    }
                }

                DisplaySmallText {
                    text: qsTr("Application")
                    Layout.topMargin: 10
                    Layout.bottomMargin: 10
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                }
                Column {
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.bottomMargin: 40
                    spacing: 0
                    Rectangle {
                        color: "#49454F"
                        width: parent.width
                        height: 1
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Switch
                        settingName: "Show expanded fligths"
                        width: parent.width
                        chevronEnabled: false
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Theme"
                        settingTextContent: "Light"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: "Language"
                        settingTextContent: "English"
                        width: parent.width
                    }
                }
            }
        }
    }
}

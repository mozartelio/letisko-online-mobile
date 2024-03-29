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

    contentItem: Item {
        id: contentBox
        anchors {
            top: parent.top
            bottom: parent.bottom
        }

        Rectangle {
            id: settingsBox
            width: parent.width / 3
            height: parent.height - anchors.topMargin - anchors.bottomMargin
            color: "#F7F2FA" //"red"
            radius: 12
            clip: true
            anchors {
                top: parent.top
                // bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 16
                bottomMargin: 16
            }

            // ColumnLayout {
            //     width: parent.width
            //     height: parent.height
            //     spacing: 17
            //     anchors {
            //         top: parent.top
            //         bottom: parent.bottom
            //         left: parent.left
            //         right: parent.right
            //         leftMargin: 40
            //         rightMargin: 40
            //         topMargin: 8
            //         bottomMargin: 100
            //     }
            ScrollView {
                width: parent.width
                height: parent.height
                clip: true
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    // leftMargin: 40
                    // rightMargin: 40
                    // topMargin: 8
                    // bottomMargin: 100
                }

                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                ScrollBar.horizontal.interactive: false
                ScrollBar.vertical.interactive: true

                ColumnLayout {
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
                    }

                    DisplaySmallText {
                        text: qsTr("Personal")
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                        Layout.leftMargin: 10
                        Layout.rightMargin: 10
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    }
                    ColumnLayout {
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: contentHeight //parent.height
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        spacing: 0
                        Rectangle {
                            color: "#49454F"
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: 1
                        }
                        SettingStrip {
                            settingType: SettingStrip.SettingType.Text
                            settingName: "Name Surname"
                            // settingTextContent: "John Controxo"
                        }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Email"
                        //     settingTextContent: "controlman@controlman.com"
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Phone number"
                        //     settingTextContent: "053434328324"
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Empty
                        //     settingName: "Adress"
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Image
                        //     settingName: "Photo"
                        //     settingImageContent: "../../assets/icons/default_plane_plug.png"
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Qualification type"
                        //     settingTextContent: "Night control man"
                        //     chevronEnabled: false
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Qualification start date"
                        //     settingTextContent: "01.02.2023"
                        //     chevronEnabled: false
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Qualification end date"
                        //     settingTextContent: "01.02.2025"
                        // }
                    }

                    DisplaySmallText {
                        text: qsTr("Application")
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                        Layout.leftMargin: 10
                        Layout.rightMargin: 10
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    }
                    ColumnLayout {
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: contentHeight //parent.height
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        spacing: 0
                        Rectangle {
                            color: "#49454F"
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: 1
                        }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Switch
                        //     settingName: "Show expanded fligths"
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Theme"
                        //     settingTextContent: "Light"
                        // }
                        // SettingStrip {
                        //     settingType: SettingStrip.SettingType.Text
                        //     settingName: "Language"
                        //     settingTextContent: "English"
                        // }
                    }
                }
            }
        }
    }
}

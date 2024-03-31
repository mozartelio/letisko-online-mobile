import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import UserAppSettings
import "../components/typography/display/text"
import "../components/typography/title/text"
import "../components"

Page {
    id: root

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    Rectangle {
        id: settingsBox
        //TODO: responsivity
        width: parent.width / 3
        height: parent.height - anchors.topMargin - anchors.bottomMargin
        color: __style.surfaceContainerLowColor
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
            }

            ColumnLayout {
                id: content
                width: settingsBox.width
                height: settingsBox.height
                spacing: 0

                MaterialButton {
                    contentText: qsTr("Log out")
                    imagePath: __style.logoutIcon
                    backgroundColor: __style.primaryColor
                    contentTextColor: __style.onPrimaryColor
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
                        settingName: qsTr("Name Surname")
                        settingTextContent: "John Controxo"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Email")
                        settingTextContent: "controlman@controlman.com"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Phone number")
                        settingTextContent: "053434328324"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Empty
                        settingName: qsTr("Adress")
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Image
                        settingName: qsTr("Photo")
                        settingImageContent: "../../assets/icons/default_plane_plug.png"
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Qualification type")
                        settingTextContent: "Night control man"
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Qualification start date")
                        settingTextContent: "01.02.2023"
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Qualification end date")
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
                        settingName: qsTr("Show expanded fligths")
                        width: parent.width
                        chevronEnabled: false
                        swithchReference.checked: UserAppSettings.showExpandedFligths
                        onValueChanged: {
                            console.log("value changed")
                            UserAppSettings.showExpandedFligths
                                    = !UserAppSettings.showExpandedFligths
                        }
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Theme")
                        settingTextContent: "Light"
                        width: parent.width
                    }
                    SettingStrip {
                        id: languageSetting
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Language")
                        settingTextContent: comboBoxLanguges.currentText
                        width: parent.width
                        ComboBox {
                            id: comboBoxLanguges
                            width: parent.width
                            height: parent.height
                            anchors.fill: parent
                            background: Item {}
                            indicator: Item {}
                            contentItem: Item {}
                            model: [qsTr("English"), qsTr("Slovak")]
                            // onActivated:
                        }
                    }
                }
            }
        }
    }
}

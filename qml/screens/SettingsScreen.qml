import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import UserAppSettings
import com.letiskoonline.UserController
import com.letiskoonline.LanguageManager
import "../components/typography/display/text"
import "../components/typography/title/text"
import "../components"

Page {
    id: root
    signal logout

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    Rectangle {
        id: settingsBox
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
                    onClicked: {
                        logout();
                        UserController.doLogout();
                    }
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
                        color: __style.settingsBoxesBorderColor
                        width: parent.width
                        height: 1
                    }

                    SettingStrip {
                        id: nameStrip
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Name and surname")
                        settingTextContent: if (UserController.user.personalInfo !== null) {
                            UserController.user.personalInfo.name + " " + UserController.user.personalInfo.surname;
                        } else {
                            "";
                        }
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        id: emailStrip
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Email")
                        settingTextContent: if (UserController.user.personalInfo !== null) {
                            UserController.user.personalInfo.email;
                        } else {
                            "";
                        }
                        chevronEnabled: false
                        width: parent.width
                    }
                    // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                    //     SettingStrip {
                    //         settingType: SettingStrip.SettingType.Text
                    //         settingName: qsTr("Phone number")
                    //         settingTextContent: "053434328324"
                    //         width: parent.width
                    //     }
                    SettingStrip {
                        id: addressStrip
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Address")
                        settingTextContent: if (UserController.user.address !== null) {
                            UserController.user.address.street + " " + UserController.user.address.buildingNumber + ", " + UserController.user.address.city + " " + UserController.user.address.zipCode + ", " + UserController.user.address.state;
                        } else {
                            "";
                        }
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Image
                        settingName: qsTr("Photo")
                        settingImageContent: if (UserController.user.isAvatarPresent()) {
                            "image://" + "pixmap_images" + "/" + UserController.user.avatarPixmapProviderId;
                        } else {
                            __style.userDefaultAvatar;
                        }
                        chevronEnabled: false
                        width: parent.width
                    }
                    // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                    //     SettingStrip {
                    //         settingType: SettingStrip.SettingType.Text
                    //         settingName: qsTr("Qualification type")
                    //         settingTextContent: "Night control man"
                    //         chevronEnabled: false
                    //         width: parent.width
                    //     }
                    //     SettingStrip {
                    //         settingType: SettingStrip.SettingType.Text
                    //         settingName: qsTr("Qualification start date")
                    //         settingTextContent: "01.02.2023"
                    //         chevronEnabled: false
                    //         width: parent.width
                    //     }
                    //     SettingStrip {
                    //         settingType: SettingStrip.SettingType.Text
                    //         settingName: qsTr("Qualification end date")
                    //         settingTextContent: "01.02.2025"
                    //         width: parent.width
                    //     }
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
                        color: __style.settingsBoxesBorderColor
                        width: parent.width
                        height: 1
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Switch
                        settingName: qsTr("Show expanded flights")
                        width: parent.width
                        chevronEnabled: false
                        swithchReference.checked: UserAppSettings.showExpandedFlights
                        onValueChanged: {
                            UserAppSettings.showExpandedFlights = !UserAppSettings.showExpandedFlights;
                        }
                    }
                    SettingStrip {
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Colour theme")
                        settingTextContent: qsTr("Light")
                        chevronEnabled: false
                        width: parent.width
                    }
                    SettingStrip {
                        id: languageSetting
                        settingType: SettingStrip.SettingType.Text
                        settingName: qsTr("Language")
                        settingTextContent: qsTr(comboBoxLanguges.currentText)
                        width: parent.width

                        ComboBox {
                            id: comboBoxLanguges
                            width: parent.width
                            height: parent.height
                            anchors.fill: parent
                            background: Item {
                            }
                            indicator: Item {
                            }
                            contentItem: Item {
                            }
                            textRole: "text"
                            valueRole: "value"

                            model: [{
                                    "value": LanguageManager.English,
                                    "text": "English"
                                }, {
                                    "value": LanguageManager.Slovak,
                                    "text": "Slovenčina"
                                }]

                            onActivated: index => {
                                             currentIndex = index
                                             languageManager.setCurrentLanguage(
                                                 model[index].value)
                                             languageSetting.settingTextContent = qsTr(
                                                 model[index].text)
                                         }

                            Component.onCompleted: {
                                currentIndex = languageManager.currentLanguage
                            }
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: UserController.user

        function onPersonalInfoChanged() {
            nameStrip.settingTextContent = UserController.user.personalInfo.name + " " + UserController.user.personalInfo.surname;
        }
    }
}

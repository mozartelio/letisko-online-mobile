import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.Material
import "./typography/title/text"

Rectangle {
    id: root
    enum SettingType {
        Empty,
        Text,
        Image,
        Switch
    }

    required property int settingType
    required property string settingName

    property url settingImageContent
    //: ""
    property string settingTextContent

    //: ""
    property bool chevronEnabled: true

    color: "transparent" //"#F5EFF7"
    clip: false
    implicitWidth: mainColumn.implicitWidth + mainColumn.anchors.leftMargin
                   + mainColumn.anchors.rightMargin //parent.width
    implicitHeight: mainColumn.implicitHeight + mainColumn.anchors.topMargin
                    + mainColumn.anchors.bottomMargin //100

    // width: parent.width
    Material.theme: Material.Light

    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: root
                    color: "#D0BCFF"
                }
                when: mouseArea.pressed
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onPressed: {
            console.log("pressed")
        }
    }

    ColumnLayout {
        id: mainColumn
        spacing: 0
        width: parent.width
        // height: image.Layout.preferredHeight + image.Layout.topMargin + image.Layout.bottomMargin
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        RowLayout {
            Layout.preferredHeight: image.Layout.preferredHeight
                                    + image.Layout.topMargin + image.Layout.bottomMargin
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true

            TitleMediumText {
                text: qsTr(settingName)
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                Layout.topMargin: 10
                Layout.bottomMargin: 10
            }

            RowLayout {
                Layout.preferredWidth: parent.width
                Layout.fillHeight: true
                TitleMediumText {
                    text: "" //settingTextContent //== ? settingTextContent : ""
                    visible: settingType == SettingStrip.SettingType.Text
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }

                RoundedImage {
                    id: image
                    imageWidth: 40
                    imageHeight: 40
                    imageSource: "" //settingImageContent // ? settingImageContent : ""
                    visible: settingType == SettingStrip.SettingType.Image

                    Layout.bottomMargin: 6
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }

                Switch {
                    visible: settingType == SettingStrip.SettingType.Switch
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }

            Image {
                width: 40
                height: 40
                source: "../../assets/icons/chevron_24px.svg"
                verticalAlignment: Image.AlignVCenter
                visible: chevronEnabled

                Layout.rightMargin: 30
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
        }

        Rectangle {
            color: "#49454F"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 1
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
        }
    }
}

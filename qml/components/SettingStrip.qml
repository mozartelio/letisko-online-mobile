import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.Material
import UserAppSettings
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

    property url settingImageContent: ""
    property string settingTextContent: ""
    property bool chevronEnabled: true
    property alias swithchReference: switchElement
    signal valueChanged

    color: __style.transparentColor
    clip: false
    implicitWidth: mainColumn.implicitWidth + mainColumn.anchors.leftMargin + mainColumn.anchors.rightMargin
    implicitHeight: mainColumn.implicitHeight + mainColumn.anchors.topMargin + mainColumn.anchors.bottomMargin

    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: root
                    color: __style.pressAccentColor
                    // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                }
                when: mouseArea.pressed
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onPressed: {
            if (settingType === SettingStrip.SettingType.Switch) {
                switchElement.checked = !switchElement.checked;
                valueChanged();
            }
        }
    }

    ColumnLayout {
        id: mainColumn
        spacing: 0
        width: parent.width
        height: image.Layout.preferredHeight + image.Layout.topMargin + image.Layout.bottomMargin
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        RowLayout { 
            width: root.width
            height: parent.height
            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 30

            TitleMediumText {
                text: settingName
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                Layout.topMargin: 10
                Layout.bottomMargin: 10
            }

            TitleMediumText {
                text: settingTextContent
                visible: settingType === SettingStrip.SettingType.Text
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
            }

            RoundedImage {
                id: image
                imageWidth: __style.icon40
                imageHeight: __style.icon40
                imageSource: settingImageContent
                visible: settingType === SettingStrip.SettingType.Image

                Layout.bottomMargin: 6
                Layout.preferredHeight: __style.icon40
                Layout.preferredWidth: __style.icon40
                Layout.topMargin: 6
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
            }

            Switch {
                id: switchElement
                visible: settingType === SettingStrip.SettingType.Switch
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
                padding: 0
                Layout.rightMargin: 0
                onToggled: valueChanged()
            }

            Image {
                width: __style.icon40
                height: __style.icon40
                source: __style.rightChevronIcon
                verticalAlignment: Image.AlignVCenter
                visible: chevronEnabled
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
        }

        Rectangle {
            color: __style.onSurfaceVariantColor
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 1
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
        }
    }
}

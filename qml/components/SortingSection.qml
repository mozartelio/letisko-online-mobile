import QtQuick
import "../components/typography/body/text"

Item {
    id: root

    enum SectionHeaderBackgroundColor {
        Dark,
        Light
    }
    required property string sectionName
    required property string leftButtonName
    required property string rightButtonName
    required property int sectionHeaderBackgroundColor

    property alias leftButton: left
    property alias rightButton: right

    implicitHeight: 39
    implicitWidth: 234

    Column {
        Rectangle {
            id: header
            width: parent.implicitWidth
            height: 24
            color: __style.transparentColor
            Component.onCompleted: {
                if (root.sectionHeaderBackgroundColor === SortingSection.Dark) {
                    color = __style.secondary50Color
                } else if (root.sectionHeaderBackgroundColor === SortingSection.Light) {
                    color = __style.primary90Color
                } else {
                    color = __style.errorColor
                }
            }

            BodyMediumText {
                text: qsTr(sectionName)
                font.bold: true
                color: if (sectionHeaderBackgroundColor === SortingSection.Dark) {
                           __style.onPrimaryColor
                       } else if (sectionHeaderBackgroundColor === SortingSection.Light) {
                           __style.darkColor
                       } else {
                           __style.errorColor
                       }
                anchors.centerIn: parent
            }
        }

        Row {
            SortingButton {
                id: left
                contentText: qsTr(leftButtonName)
                width: root.implicitWidth / 2
            }
            SortingButton {
                id: right
                contentText: qsTr(rightButtonName)
                width: root.implicitWidth / 2
            }
        }
    }
}

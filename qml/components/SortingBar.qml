import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../components/divider/"
import "../components/"
import "../components/typography/label/text"
import "../components/typography/title/text"
import "../components/typography/body/text"

Rectangle {
    id: root

    required property string leftSectionHeader
    required property string leftSectionLeftButtonText
    required property string leftSectionRightButtonText

    required property string rigthSectionHeader
    required property string rigthSectionLeftButtonText
    required property string rigthSectionRightButtonText

    signal valueChanged(int value)

    color: __style.surfaceColor
    implicitHeight: 77
    implicitWidth: 467

    // Layout.preferredWidth: 467
    // Layout.preferredHeight: 77
    Rectangle {
        id: leftSection
        width: root.implicitWidth / 2
        height: 24
        color: __style.secondary50Color
        anchors {
            top: root.top
            left: root.left
        }
        BodySmallText {
            text: qsTr(leftSectionHeader)
            color: __style.onPrimaryColor
            anchors.centerIn: parent
        }
    }
    Rectangle {
        id: rightSection
        width: root.implicitWidth / 2
        height: 24
        color: __style.primary90Color
        anchors {
            top: root.top
            right: root.right
        }
        BodySmallText {
            text: qsTr(rigthSectionHeader)
            color: __style.darkColor
            anchors.centerIn: parent
        }
    }

    RowLayout {
        spacing: 0
        height: parent.implicitWidth
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        ButtonGroup {
            id: sortingButtonsGroup
            onClicked: {
                valueChanged(index)
            }
        }

        SortingButton {
            contentText: qsTr(leftSectionLeftButtonText)
            ButtonGroup.group: sortingButtonsGroup
            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth: root.Layout.preferredWidth / 4
            Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        }
        SortingButton {
            contentText: qsTr(leftSectionRightButtonText)
            ButtonGroup.group: sortingButtonsGroup
            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth: root.Layout.preferredWidth / 4
            Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        }

        SortingButton {
            contentText: qsTr(rigthSectionLeftButtonText)
            ButtonGroup.group: sortingButtonsGroup
            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth: root.Layout.preferredWidth / 4
            Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        }
        SortingButton {
            contentText: qsTr(rigthSectionRightButtonText)
            ButtonGroup.group: sortingButtonsGroup
            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth: root.Layout.preferredWidth / 4
            Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        }
    }
}

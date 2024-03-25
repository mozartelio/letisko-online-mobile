import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
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

    color: "#FEF7FF"
    Layout.preferredWidth: 467
    Layout.preferredHeight: 77

    Rectangle {
        id: leftSection
        width: root.Layout.preferredWidth / 2
        height: 24
        color: "#7A7289"
        anchors {
            top: root.top
            left: root.left
        }
        BodySmallText {
            text: qsTr(leftSectionHeader)
            color: "white"
            anchors.centerIn: parent
        }
    }
    Rectangle {
        id: rightSection
        width: root.Layout.preferredWidth / 2
        height: 24
        color: "#EADDFF"
        anchors {
            top: root.top
            right: root.right
        }
        BodySmallText {
            text: qsTr(rigthSectionHeader)
            color: "#322F35"
            anchors.centerIn: parent
        }
    }

    RowLayout {
        spacing: 0
        height: parent.Layout.preferredHeight
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        ButtonGroup {
            id: sortingButtonsGroup
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

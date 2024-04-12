import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "./typography/label/text"
import "./typography/title/text"
import "./typography/body/text"

Item {
    id: root

    property string departureSectionHeader: qsTr("Departure time")
    property string departureLeftButtonName: qsTr("Сlosest to farthest")
    property string departureRightButtonName: qsTr("Farthest to closest")

    property string arrivalSectionHeader: qsTr("Arrival time")
    property string arrivalRightButtonName: qsTr("Сlosest to farthest")
    property string arrivalLefttButtonName: qsTr("Farthest to closest")

    signal valueChanged(int value)

    height: 77
    width: 350

    // Layout.preferredWidth: 467
    // Layout.preferredHeight: 77
    ButtonGroup {
        id: sortingButtonsGroup
        onClicked: // valueChanged(index)
        {

        }
    }
    RowLayout {
        spacing: 0
        width: parent.width

        // height: parent.implicitWidth
        // anchors {
        //     top: parent.top
        //     bottom: parent.bottom
        //     left: parent.left
        //     right: parent.right
        // }
        SortingSection {
            leftButton.width: parent.width / 2
            rightButton.width: parent.width / 2
            leftButton.ButtonGroup.group: sortingButtonsGroup
            rightButton.ButtonGroup.group: sortingButtonsGroup
            sectionName: departureSectionHeader
            leftButtonName: departureLeftButtonName
            rightButtonName: departureRightButtonName
            sectionHeaderBackgroundColor: SortingSection.Dark
            Layout.preferredWidth: root.width /// 2
        }

        SortingSection {
            leftButton.width: parent.width / 2
            rightButton.width: parent.width / 2
            leftButton.ButtonGroup.group: sortingButtonsGroup
            rightButton.ButtonGroup.group: sortingButtonsGroup
            sectionName: arrivalSectionHeader
            leftButtonName: arrivalLefttButtonName
            rightButtonName: arrivalRightButtonName
            sectionHeaderBackgroundColor: SortingSection.Light
            Layout.preferredWidth: root.width /// 2
        }

        // SortingButton {
        //     contentText: qsTr(arrivalRightButtonName)
        //     ButtonGroup.group: sortingButtonsGroup
        //     Layout.alignment: Qt.AlignBottom
        //     Layout.preferredWidth: root.Layout.preferredWidth / 4
        //     Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        // }
        // SortingButton {
        //     contentText: qsTr(arrivalLefttButtonName)
        //     ButtonGroup.group: sortingButtonsGroup
        //     Layout.alignment: Qt.AlignBottom
        //     Layout.preferredWidth: root.Layout.preferredWidth / 4
        //     Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        // }

        // SortingButton {
        //     contentText: qsTr(departureLeftButtonName)
        //     ButtonGroup.group: sortingButtonsGroup
        //     Layout.alignment: Qt.AlignBottom
        //     Layout.preferredWidth: root.Layout.preferredWidth / 4
        //     Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        // }
        // SortingButton {
        //     contentText: qsTr(departureRightButtonName)
        //     ButtonGroup.group: sortingButtonsGroup
        //     Layout.alignment: Qt.AlignBottom
        //     Layout.preferredWidth: root.Layout.preferredWidth / 4
        //     Layout.preferredHeight: root.Layout.preferredHeight - leftSection.height
        // }
    }
}

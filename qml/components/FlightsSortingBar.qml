import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import com.letiskoonline.FlightsRoles

import "./typography/label/text"
import "./typography/title/text"
import "./typography/body/text"

Item {
    id: root

    height: 77
    width: 450

    ButtonGroup {
        id: sortingButtonsGroup
    }
    RowLayout {
        spacing: 0
        width: parent.width

        SortingSection {
            id: departureSorting
            sectionName: qsTr("Departure time")
            leftButtonName: qsTr("Сlosest to farthest")
            rightButtonName: qsTr("Farthest to closest")
            sectionHeaderBackgroundColor: SortingSection.Dark

            leftButton.width: parent.width / 2
            rightButton.width: parent.width / 2
            leftButton.ButtonGroup.group: sortingButtonsGroup
            rightButton.ButtonGroup.group: sortingButtonsGroup

            leftButton.onClicked: {
                flightsFilterProxyModel.setSortOrder(
                            FlightsRoles.DepartureTimeRole, true)
            }
            rightButton.onClicked: {
                flightsFilterProxyModel.setSortOrder(
                            FlightsRoles.DepartureTimeRole, false)
            }

            Layout.preferredWidth: root.width
        }

        SortingSection {
            id: arrivalSorting
            sectionName: qsTr("Arrival time")
            leftButtonName: qsTr("Сlosest to farthest")
            rightButtonName: qsTr("Farthest to closest")
            sectionHeaderBackgroundColor: SortingSection.Light

            leftButton.width: parent.width / 2
            rightButton.width: parent.width / 2
            leftButton.ButtonGroup.group: sortingButtonsGroup
            rightButton.ButtonGroup.group: sortingButtonsGroup

            leftButton.onClicked: flightsFilterProxyModel.setSortOrder(
                                      FlightsRoles.ArrivalTimeRole, true)
            rightButton.onClicked: flightsFilterProxyModel.setSortOrder(
                                       FlightsRoles.ArrivalTimeRole, false)

            Layout.preferredWidth: root.width
        }
    }

    Component.onCompleted: {
        departureSorting.leftButton.checked = true
        flightsFilterProxyModel.setSortOrder(FlightsRoles.DepartureTimeRole,
                                             true)
    }
}

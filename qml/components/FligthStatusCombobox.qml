import QtQuick
import QtQuick.Controls
import com.letiskoonline.FlightRequestStatus
import com.letiskoonline.FlightsController

ComboBox {
    id: root

    required property int currentFlightStatus
    required property int flightRequestId

    width: 200
    height: 50
    editable: false
    background: Item {}
    indicator: Item {}

    model: ListModel {
        id: model

        ListElement {
            name: qsTr("Approved")
            value: FlightRequestStatus.Approved
            isVisible: 1
            isEnabled: 1
        }
        ListElement {
            name: qsTr("Denied")
            value: FlightRequestStatus.Denied
            isVisible: 1
            isEnabled: 1
        }
        ListElement {
            name: qsTr("Pending")
            value: FlightRequestStatus.Pending
            isVisible: 0
            isEnabled: 0
        }
    }

    delegate: Loader {
        width: root.width
        height: model.isVisible ? 50 : 0
        visible: model.isVisible
        enabled: model.isEnabled
        sourceComponent: FlightStatusChip {
            id: fligthChipComponent
            flightStatus: model.value
            MouseArea {
                anchors.fill: parent
                enabled: root.enabled
                onClicked: {
                    root.popup.close()
                    currentFlightStatus = fligthChipComponent.flightStatus
                    setCurrentIndexAccordingCurrentStatus()
                    FlightsController.changeFlightRequestStatus(
                                flightRequestId, currentFlightStatus)
                }
            }
        }
    }

    contentItem: FlightStatusChip {
        id: item
        width: root.width
        height: 50
    }

    onCurrentFlightStatusChanged: {
        setCurrentIndexAccordingCurrentStatus()
        item.flightStatus = model.get(root.currentIndex).value
    }

    function setCurrentIndexAccordingCurrentStatus() {
        for (var i = 0; i < model.count; i++) {
            if (model.get(i).value == root.currentFlightStatus) {
                root.currentIndex = i
                break
            }
        }
    }
}

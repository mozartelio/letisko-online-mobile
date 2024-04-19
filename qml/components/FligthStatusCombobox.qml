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
        }
        ListElement {
            name: qsTr("Denied")
            value: FlightRequestStatus.Denied
        }
        ListElement {
            name: qsTr("Pending")
            value: FlightRequestStatus.Pending
        }
    }

    delegate: Loader {
        width: root.width
        height: 50
        sourceComponent: FlightStatusChip {
            id: fligthChipComponent
            flightStatus: model.value
            MouseArea {
                anchors.fill: parent
                enabled: root.enabled
                onClicked: {
                    root.popup.close()
                    if ((currentFlightStatus === FlightRequestStatus.Denied
                         || currentFlightStatus === FlightRequestStatus.Approved)
                            && fligthChipComponent.flightStatus === FlightRequestStatus.Pending) {
                        warningDialog.open()
                        return
                    }
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

    Dialog {
        id: warningDialog
        title: qsTr("It is not possible to change flight status back to pending!")
        standardButtons: Dialog.Ok
        modal: Qt.ApplicationModal
        anchors.centerIn: Overlay.overlay
        Overlay.modal: Rectangle {
            color: __style.popupSemiTransparentDarkColor
        }
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

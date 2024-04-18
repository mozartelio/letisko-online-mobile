import QtQuick
import QtQuick.Controls
import com.letiskoonline.FlightRequestStatus
import com.letiskoonline.FlightsController

ComboBox {
    id: flightStatusComboBox

    required property int currentFlightStatus
    required property int flightRequestId

    width: 200
    height: 50
    editable: false
    background: Item {
    }
    indicator: Item {
    }

    model:
    ListModel {
    }
    Component.onCompleted: {
        model.append({
                "name": flightRequestStatus.statusToString(FlightRequestStatus.Approved),
                "value": FlightRequestStatus.Approved
            });
        model.append({
                "name": flightRequestStatus.statusToString(FlightRequestStatus.Denied),
                "value": FlightRequestStatus.Denied
            });
        model.append({
                "name": flightRequestStatus.statusToString(FlightRequestStatus.Pending),
                "value": FlightRequestStatus.Pending
            });
        setCurrentIndexAccordingCurrentState();
    }

    delegate: Loader {
        width: flightStatusComboBox.width
        height: 50
        sourceComponent: FlightStatusChip {
            id: fligthChipComponent
            flightStatus: model.value
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    enabled: flightStatusComboBox.enabled;
                    currentFlightStatus = fligthChipComponent.flightStatus;
                    setCurrentIndexAccordingCurrentState();
                    FlightsController.changeFlightRequestStatus(flightRequestId, currentFlightStatus);
                    flightStatusComboBox.popup.close();
                }
            }
        }
    }

    contentItem: FlightStatusChip {
        width: flightStatusComboBox.width
        height: 50
        flightStatus: model.get(currentIndex).value
    }

    onCurrentIndexChanged: {
        currentFlightStatus = model.get(currentIndex).value;
    }

    function setCurrentIndexAccordingCurrentState() {
        for (var i = 0; i < model.count; i++) {
            if (model.get(i).value === currentFlightStatus) {
                currentIndex = i;
                break;
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import "../components/divider/"
import "../components/"

Page {

    Column {
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        FlightStrip {
            callsign: "AWS152ALPHA"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        FlightStrip {
            callsign: "AWS152ALPHA"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // FlightStatus {
    //     status: FlightStatus.Status.Pending
    // }

    // SearchBar {
    //     anchors {
    //         horizontalCenter: parent.horizontalCenter
    //     }
    // }
    background: Rectangle {
        color: "white" //"salmon"
    }
    // contentItem: Item {
    //     id: root
    //     anchors.fill: parent
    //     anchors.margins: 20

    //     HorizontalDividerSubhead {
    //         width: parent.width
    //         textContent: qsTr("Ongoing flights")
    //     }
    // }
}

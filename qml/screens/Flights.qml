import QtQuick
import QtQuick.Controls
import "../components/divider/"
import "../components/"

Page {
    id: root
    background: Rectangle {
        color: "white" //"salmon"
    }

    // FlightStatus {
    //     status: FlightStatus.Status.Pending
    // }
    contentItem: Column {
        width: root.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        anchors.fill: parent
        spacing: 40

        // Item {
        //     SearchBar {
        //         width: root.width
        //         anchors {
        //             horizontalCenter: parent.horizontalCenter
        //         }
        //     }
        // }
        Item {
            HorizontalDividerSubhead {
                width: root.width
                textContent: qsTr("Ongoing flights")
            }
        }

        Item {
            Column {
                width: root.width
                FlightStrip {
                    callsign: "AWS152ALPHA"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                FlightStrip {
                    callsign: "AWS152ALPHA"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Layouts
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
    contentItem: ColumnLayout {
        id: column
        width: root.width
        height: root.height
        spacing: 10
        anchors {
            left: root.left
            right: root.right
            top: root.top
            bottom: root.bottom
            margins: 40
        }

        SearchBar {
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
            Layout.preferredHeight: 56
            Layout.preferredWidth: column.width
        }

        HorizontalDividerSubhead {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredHeight: 26
            Layout.preferredWidth: column.width

            textContent: qsTr("Ongoing flights")
        }

        Column {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 356
            Layout.preferredWidth: column.width

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

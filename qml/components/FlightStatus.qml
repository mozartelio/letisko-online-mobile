import QtQuick
import QtQuick.Layouts
import "./typography/label/text/"
import "../components/"

Rectangle {
    enum Status {
        Denied,
        Confirmed,
        Pending
    }
    property int status
    id: root
    width: 140
    height: 32
    color: status === FlightStatus.Status.Confirmed ? "#625B71" : status === FlightStatus.Status.Denied ? "#8C1D18" : "#6750A4"
    radius: 8
    border {
        width: 1
        color: "#79747E"
    }

    // DEBUG
    // MouseArea {
    //     anchors.fill: parent
    //     onPressed: console.log(
    //                    "current status:" + status + " denied value:" + FlightStatus.Status.Pending)
    // }
    RowLayout {
        spacing: 8
        width: parent.width
        anchors {
            fill: root
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            leftMargin: 16
            rightMargin: 16
            topMargin: 6
            bottomMargin: 6
        }

        LabelLarge {
            color: "white"
            Layout.preferredWidth: contentWidth
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignBaseline
            text: status === FlightStatus.Status.Confirmed ? qsTr("Confirmed") : status === FlightStatus.Status.Denied ? qsTr("Denied") : qsTr("Pending")
        }

        // TODO: does not work!
        // Image {
        //     id: icon
        //     width: 24
        //     height: 24
        //     source: if (status === FlightStatus.Confirmed)
        //                 return confirmedIconPath
        //             else if (status === FlightStatus.Denied)
        //                 return deniedIconPath
        //             else
        //                 return pendingIconPath
        //     anchors.verticalCenter: parent.verticalCenter
        // }
        Image {

            // Nested Image for pending state
            width: 24
            height: 24
            source: "../../assets/icons/more-24px.svg"
            visible: status === FlightStatus.Status.Pending
            verticalAlignment: Image.AlignVCenter
        }
        Image {
            // Layout.alignment: /*Qt.AlignHCenter |*/ Qt.AlignVCenter //Qt.AlignBaseline
            // Nested Image for confirmed state
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            source: "../../assets/icons/check_small-24px.svg"
            visible: status === FlightStatus.Status.Confirmed
            verticalAlignment: Image.AlignVCenter
        }
        Image {
            // Layout.alignment: Qt.AlignBaseline
            // Nested Image for denied state
            width: 24
            height: 24
            source: "../../assets/icons/close-24px.svg"
            visible: status === FlightStatus.Status.Denied
            verticalAlignment: Image.AlignVCenter
        }
    }
}

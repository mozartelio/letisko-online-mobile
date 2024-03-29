import QtQuick
import QtQuick.Layouts
import "./typography/label/text/"
import "../components/"

Rectangle {
    id: root
    enum Status {
        Denied,
        Confirmed,
        Pending
    }
    property int status

    width: content.implicitWidth + content.anchors.leftMargin + content.anchors.rightMargin
    height: 32
    radius: 8
    border {
        width: 1
        color: "#79747E"
    }
    color: {
        if (root.status == FlightStatus.Status.Confirmed)
            return "#625B71"
        else if (root.status == FlightStatus.Status.Denied)
            return "#8C1D18"
        else if (root.status == FlightStatus.Status.Pending)
            return "#6750A4"
        else
            return ""
    }

    RowLayout {
        id: content
        width: textLabel.implicitWidth + icon.implicitWidth
        spacing: 8
        anchors {
            fill: root
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            leftMargin: 16
            rightMargin: 16
            topMargin: 6
            bottomMargin: 6
        }

        LabelLargeText {
            id: textLabel
            color: "white"
            Layout.preferredWidth: contentWidth
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignBaseline | Qt.AlignRight
            text: status == FlightStatus.Status.Confirmed ? qsTr("Confirmed") : status == FlightStatus.Status.Denied ? qsTr("Denied") : qsTr("Pending")
        }

        Image {
            id: icon
            width: 24
            height: 24
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            source: {
                if (root.status == FlightStatus.Status.Confirmed)
                    return "../../assets/icons/check_small-24px.svg"
                else if (root.status == FlightStatus.Status.Denied)
                    return "../../assets/icons/close-24px.svg"
                else if (root.status == FlightStatus.Status.Pending)
                    return "../../assets/icons/more-24px.svg"
                else
                    return ""
            }
        }
    }
}

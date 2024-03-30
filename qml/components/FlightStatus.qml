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
            return __style.secondaryColor
        else if (root.status == FlightStatus.Status.Denied)
            return __style.errorContainerColor
        else if (root.status == FlightStatus.Status.Pending)
            return __style.primaryColor
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
            color: __style.onPrimaryColor
            Layout.preferredWidth: contentWidth
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignBaseline | Qt.AlignRight
            text: status == FlightStatus.Status.Confirmed ? qsTr("Confirmed") : status == FlightStatus.Status.Denied ? qsTr("Denied") : qsTr("Pending")
        }

        Image {
            id: icon
            width: __style.icon24
            height: __style.icon24
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            source: {
                if (root.status == FlightStatus.Status.Confirmed)
                    return __style.checkSmallIcon
                else if (root.status == FlightStatus.Status.Denied)
                    return __style.closeIcon
                else if (root.status == FlightStatus.Status.Pending)
                    return __style.moreIcon
                else
                    return ""
            }
        }
    }
}

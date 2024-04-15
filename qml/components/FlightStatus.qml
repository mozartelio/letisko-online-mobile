import QtQuick
import QtQuick.Controls
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
    property int flightStatus

    width: Math.min(
               content.implicitWidth + content.anchors.leftMargin + content.anchors.rightMargin,
               privates.maxWidth)
    height: 32
    radius: 8
    border {
        width: 1
        color: __style.outlineColor
    }
    color: {
        if (root.flightStatus === FlightStatus.Status.Confirmed)
            return __style.secondaryColor
        else if (root.flightStatus === FlightStatus.Status.Denied)
            return __style.errorContainerColor
        else if (root.flightStatus === FlightStatus.Status.Pending)
            return __style.primaryColor
        else
            return ""
    }

    RowLayout {
        id: content
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
            text: flightStatus === FlightStatus.Status.Confirmed ? qsTr("Confirmed") : flightStatus === FlightStatus.Status.Denied ? qsTr("Denied") : qsTr("Pending")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            maximumLineCount: 2
            Layout.preferredWidth: Math.min(contentWidth, privates.maxWidth)
            Layout.preferredHeight: 20
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        Image {
            id: icon
            width: __style.icon24
            height: __style.icon24
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter // Adjusted alignment
            source: {
                if (root.flightStatus === FlightStatus.Status.Confirmed)
                    return __style.checkSmallIcon
                else if (root.flightStatus === FlightStatus.Status.Denied)
                    return __style.closeIcon
                else if (root.flightStatus === FlightStatus.Status.Pending)
                    return __style.moreIcon
                else
                    return ""
            }
        }
    }

    QtObject {
        id: privates
        property int maxWidth: 200
    }
}

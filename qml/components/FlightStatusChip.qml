import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.letiskoonline.FlightRequestStatus
import "./typography/label/text/"
import "../components/"

Rectangle {
    id: root

    required property int flightStatus

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
        if (root.flightStatus === FlightRequestStatus.Approved)
            return __style.secondaryColor
        else if (root.flightStatus === FlightRequestStatus.Denied)
            return __style.errorContainerColor
        else if (root.flightStatus === FlightRequestStatus.Pending)
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
            text: flightStatus === FlightRequestStatus.Approved ? qsTr("Approved") : flightStatus === FlightRequestStatus.Denied ? qsTr("Denied") : qsTr("Pending")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            maximumLineCount: 2
            Layout.preferredWidth: root.width
            Layout.preferredHeight: 20
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        Image {
            id: icon
            width: __style.icon24
            height: __style.icon24
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            source: {
                if (root.flightStatus === FlightRequestStatus.Approved)
                    return __style.checkSmallIcon
                else if (root.flightStatus === FlightRequestStatus.Denied)
                    return __style.closeIcon
                else if (root.flightStatus === FlightRequestStatus.Pending)
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

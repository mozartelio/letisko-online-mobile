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

    width: content.implicitWidth + content.anchors.leftMargin + content.anchors.rightMargin
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
        // width: textLabel.implicitWidth + icon.implicitWidth
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

        // ComboBox {
        //     editable: false
        //     model: ListModel {
        //         id: model
        //         ListElement {
        //             text: "Banana"
        //         }
        //         ListElement {
        //             text: "Apple"
        //         }
        //         ListElement {
        //             text: "Coconut"
        //         }
        //     }
        //     onAccepted: {
        //         if (find(editText) === -1)
        //             model.append({
        //                              "text": editText
        //                          })
        //     }
        //     // anchors.fill: parent
        //     Layout.preferredWidth: 100
        //     Layout.preferredHeight: 27
        //     Layout.fillHeight: true
        //     Layout.fillWidth: true
        //     // popup: Popup {
        //     //     background: Rectangle {
        //     //         color: "transparent"
        //     //         // layer.enabled: true
        //     //         // layer.effect: GaussianBlur {
        //     //         // radius: 10
        //     //         // }
        //     //     }
        //     // }
        // }
        LabelLargeText {
            id: textLabel
            color: __style.onPrimaryColor
            Layout.preferredWidth: contentWidth
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignBaseline | Qt.AlignRight
            text: flightStatus === FlightStatus.Status.Confirmed ? qsTr("Confirmed") : flightStatus === FlightStatus.Status.Denied ? qsTr("Denied") : qsTr("Pending")
        }

        Image {
            id: icon
            width: __style.icon24
            height: __style.icon24
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
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
}

import QtQuick
import QtQuick.Layouts
import "./typography/body/input"

BodyLargeInput {
    id: root
    implicitWidth: 720
    implicitHeight: __style.searchbarHeight
    clip: true
    leftPadding: 16 + icon.width
    rightPadding: 16
    placeholderText: qsTr("Type something....")

    background: Rectangle {
        id: background
        color: __style.surfaceContainerHighColor
        height: parent.height
        width: parent.width
        radius: 28
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: icon
            width: __style.icon24
            height: __style.icon24
            source: __style.searchIcon
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 8
            }
        }
    }
}

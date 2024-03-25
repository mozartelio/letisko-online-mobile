import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import "./typography/body/input"

BodyLargeInput {
    id: root
    implicitWidth: 720
    implicitHeight: 56
    clip: true
    leftPadding: 16 + icon.width
    rightPadding: 16
    placeholderText: qsTr("Type something....")

    background: Rectangle {
        id: background
        color: "#ECE6F0"
        height: 56
        width: parent.width
        radius: 28
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: icon
            width: 24
            height: 24
            source: "../../assets/icons/search-24px.svg"
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 8
            }
        }
    }
}

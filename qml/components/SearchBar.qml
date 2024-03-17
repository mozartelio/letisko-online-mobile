import QtQuick
import QtQuick.Layouts
import "./typography/body/input"

BodyLargeInput {
    id: root
    width: parent.width
    height: parent.height
    verticalAlignment: TextInput.AlignVCenter
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

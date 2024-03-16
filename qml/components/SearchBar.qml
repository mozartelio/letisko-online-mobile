import QtQuick
import QtQuick.Layouts
import "./typography/body/input"

Rectangle {
    id: root
    color: "#ECE6F0"
    height: 56
    width: (2 * parent.width) / 4
    radius: 28

    Row {

        id: searchBarRow
        spacing: 4
        padding: 4
        width: parent.width
        height: parent.height - 2 * padding

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            // verticalCenter: parent.verticalCenter
            fill: root
        }

        BodyLargeInput {
            // TextField{
            width: (14 * root.width) / 15

            height: parent.height
            verticalAlignment: TextInput.AlignVCenter
            clip: true
            leftPadding: 16
            rightPadding: 16
            placeholderText: qsTr("Type something....")
            // background: Rectangle {
            //     implicitHeight: parent.height
            //     implicitWidth: 20
            //     color: "red" //"transparent"
            // }
        }

        MouseArea {
            id: searchArea
            height: parent.height
            width: height
            onPressed: console.log("pressed")

            Image {
                id: icon
                width: 24
                height: 24
                source: "../../assets/icons/search-24px.svg"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}

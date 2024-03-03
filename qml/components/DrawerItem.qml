import QtQuick
import QtQuick.Layouts
import "./typography/label"

Rectangle {
    id: drawerItem
    property string iconSource
    property string itemName

    signal press

    color: "#00FFFFFF"
    radius: 100
    height: 56
    width: parent.width

    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.color = '#E8DEF8'
            console.log("pressed")
        }
        onReleased: {
            parent.color = '#00FFFFFF'
            console.log("released")
        }
    }

    Row {
        id: drawerItemRow
        spacing: 12
        width: parent.width
        anchors {
            leftMargin: 16
            rightMargin: 24
            topMargin: 16
            bottomMargin: 16
            fill: parent
        }

        Image {
            id: icon
            width: 24
            height: 24
            source: iconSource
        }

        LabelLargeProminent {
            id: text
            width: drawerItemRow.width - icon.width - drawerItemRow.spacing
            text: qsTr(itemName)
        }
    }
}

import QtQuick
import QtQuick.Layouts
import "./typography/label/text"

Rectangle {
    id: drawerItem
    required property url iconSource
    required property string itemName

    signal drawerItemPressed

    objectName: "DrawerItem"
    color: __style.transparentColor
    radius: 100
    height: __style.drawerItemHeight
    width: parent.width

    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.color = __style.pressAccentColor
            drawerItemPressed()
            console.log("pressed")
        }
        onReleased: {
            parent.color = __style.transparentColor
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
            width: __style.icon24
            height: __style.icon24
            source: iconSource
        }

        LabelLargeProminentText {
            id: text
            width: drawerItemRow.width - icon.width - drawerItemRow.spacing
            text: qsTr(itemName)
        }
    }
}

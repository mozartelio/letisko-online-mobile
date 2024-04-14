import QtQuick
import QtQuick.Layouts
import "./typography/label/text"

Rectangle {
    id: root

    required property url iconSource
    required property string itemName
    property bool isActive: true

    signal drawerItemPressed

    color: __style.transparentColor
    radius: 100
    height: __style.drawerItemHeight
    width: parent.width

    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: root
                    color: isActive ? __style.pressAccentColor : __style.transparentColor
                }
                when: mouseArea.pressed
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: {
            drawerItemPressed()
            console.log("pressed")
        }
        onReleased: {
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
            color: isActive ? __style.blackColor : __style.inactiveColor
        }
    }
}

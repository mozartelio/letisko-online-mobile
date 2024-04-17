import QtQuick
import QtQuick.Controls

Popup {
    id: root
    modal: true
    focus: true
    width: parent.width
    height: parent.height
    closePolicy: Popup.NoAutoClose
    anchors.centerIn: Overlay.overlay
    contentItem: Item {
    }
    background: Rectangle {
        id: cover
        visible: root.opened
        z: 10
        color: __style.popupSemiTransparentLightColor
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            fill: parent
        }
        BusyIndicator {
            running: cover.visible
            anchors.centerIn: parent
            background: Item {
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root

    property alias leftButon: leftButon
    property alias rightButton: rightButton
    default property alias content: contentColumn.children

    implicitWidth: 300
    implicitHeight: 300
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
    anchors.centerIn: Overlay.overlay

    background: Rectangle {
        color: __style.surfaceContainerHighColor
        radius: 28
    }

    Overlay.modal: Rectangle {
        color: __style.popupSemiTransparentDarkColor
    }

    Item {
        id: contentColumn
        clip: true
        anchors {
            top: parent.top
            bottom: controlButtons.top
            left: parent.left
            right: parent.right
            margins: 20
        }
    }

    RowLayout {
        id: controlButtons
        width: parent.width
        anchors {
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }

        MaterialButton {
            id: leftButon
            Layout.alignment: Qt.AlignRight
            contentText: qsTr("Confirm")
            onClicked: root.close()
        }

        MaterialButton {
            id: rightButton
            Layout.alignment: Qt.AlignRight
            contentText: qsTr("Cancel")
            onClicked: root.close()
        }
    }
}

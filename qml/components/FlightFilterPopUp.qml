import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import "./typography/headline/text"
import "./typography/label/text"

Popup {
    id: root
    Material.theme: Material.Light
    width: 300
    height: 400
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
    anchors.centerIn: Overlay.overlay

    background: Rectangle {
        color: "#CAC4D0"
        radius: 28
    }

    Overlay.modal: Rectangle {
        color: "#aacfdbe7"
    }

    ColumnLayout {
        spacing: 0
        HeadlineSmallText {
            horizontalAlignment: Text.AlignLeft
            text: "Filters"
            Layout.margins: 24
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            width: parent.width

            MaterialButton {
                Layout.alignment: Qt.AlignRight
                contentText: "Confirm"
                // TODO:
                onClicked: root.close()
            }
            MaterialButton {
                Layout.alignment: Qt.AlignRight
                contentText: "Cancel"
                onClicked: root.close()
            }
        }
    }
}

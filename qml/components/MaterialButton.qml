import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import "./typography/label/text"

Button {
    id: button
    required property string contentText

    property color backgroundColor: "transparent"
    property string contentTextColor: "#49454F"
    property string imagePath: ""

    Material.theme: Material.Light
    background: Rectangle {
        id: buttonBackground
        color: backgroundColor
        radius: 100
    }
    contentItem: Row {
        spacing: 8
        LabelLargeText {
            id: buttonText
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            text: contentText
            color: contentTextColor
            anchors {
                leftMargin: 12
                rightMargin: 12
                topMargin: 10
                bottomMargin: 10
            }
        }

        Image {
            id: buttonImage
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            source: imagePath
            verticalAlignment: Image.AlignVCenter
            visible: imagePath !== "" ? true : false
        }
    }
    StateGroup {states: [
        State {
            name: "pressed"
            PropertyChanges {
                target: buttonBackground
                color: "#6750A4"
                opacity: 0.12
            }
            PropertyChanges {
                target: buttonText
                color: "#6750A4"
            }

            when: button.pressed
        }
    ]}
}

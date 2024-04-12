import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "./typography/label/text"

Button {
    id: root
    property string contentText

    property color backgroundColor: __style.transparentColor
    property string contentTextColor: __style.primaryColor
    property string imagePath: ""

    background: Rectangle {
        id: buttonBackground
        color: backgroundColor
        radius: 100
    }
    contentItem: Row {
        id: content
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
            source: imagePath
            verticalAlignment: Image.AlignVCenter
            visible: imagePath !== "" ? true : false
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.preferredWidth: __style.icon24
            Layout.preferredHeight: __style.icon24
        }
    }
    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: buttonBackground
                    color: __style.primaryColor
                    opacity: 0.12
                }
                PropertyChanges {
                    target: buttonText
                    color: __style.primaryColor
                }

                when: root.pressed
            }
        ]
    }
}

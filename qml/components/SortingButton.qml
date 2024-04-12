import QtQuick
import QtQuick.Controls

import QtQuick.Layouts
import "../components/typography/title/text"

Button {
    id: root
    required property string contentText

    display: AbstractButton.TextOnly
    checkable: true
    contentItem: TitleSmallText {
        id: contentItem
        text: contentText
        color: __style.onSurfaceVariantColor
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        horizontalAlignment: Text.AlignHCenter
    }
    background: Rectangle {
        id: buttonBackground
        anchors {
            fill: parent
        }
        color: __style.surfaceColor
    }
    StateGroup {
        states: [
            State {
                name: "checked"
                PropertyChanges {
                    target: contentItem
                    color: __style.primaryColor
                }
                PropertyChanges {
                    target: buttonBackground
                    color: __style.pressAccentColor
                }
                when: root.checked
            }
        ]
    }
}

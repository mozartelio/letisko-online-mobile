import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../components/typography/title/text"

Button {
    id: root
    required property string contentText

    display: AbstractButton.TextOnly
    checkable: true
    Material.theme: Material.Light
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
        color: __style.transparentColor
    }
    StateGroup {
        states: [
            State {
                name: "ckecked"
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

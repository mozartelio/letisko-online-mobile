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
        color: "#49454F"
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        horizontalAlignment: Text.AlignHCenter
    }
    background: Rectangle {
        id: buttonBackground
        anchors {
            fill: parent
        }
        color: "transparent"
    }
    StateGroup {
        states: [
            State {
                name: "ckecked"
                PropertyChanges {
                    target: contentItem
                    color: "#6750A4"
                }
                PropertyChanges {
                    target: buttonBackground
                    color: "#D0BCFF"
                }
                when: root.checked
            }
        ]
    }
}

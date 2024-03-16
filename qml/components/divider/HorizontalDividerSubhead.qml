import QtQuick
import "../typography/title/text"

Item {
    id: root
    property string textContent: ""

    Column {
        spacing: 4
        Rectangle {
            color: "#CAC4D0"
            height: 2
            width: root.width
        }
        TitleLargeText {
            text: textContent
        }
    }
}

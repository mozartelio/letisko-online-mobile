import QtQuick
import "../typography/title/text"

Item {
    id: root
    required property string textContent

    Column {
        spacing: 4
        Rectangle {
            color: __style.outlineVariant
            height: 2
            width: root.width
        }
        TitleLargeText {
            text: textContent
        }
    }
}

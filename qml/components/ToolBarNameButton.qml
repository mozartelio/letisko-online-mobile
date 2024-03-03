import QtQuick
import "./typography/title"

Item {
    Row {
        id: toolBarNameButtonRow
        width: 218
        height: 48
        spacing: 3
        Image {
            id: avatar
            source: "../../assets/icons/airport.svg"
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
        }
        TitleLarge {
            width: toolBarNameButtonRow.width - avatar.width - toolBarNameButtonRow.spacing
            text: "Name Surname"
        }
    }
}

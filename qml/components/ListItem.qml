import QtQuick
import QtQuick.Layouts

import "./typography/body/text"

Rectangle {
    property string headline
    property string description
    property string imageSource
    property type name: "sssssssssssssssssssssssssssssssssssssssssssssssssssssss" //value

    id: root
    color: "#FEF7FF"
    RowLayout {
        anchors.fill: parent

        Image {
            id: icon
            source: imageSource
        }

        Column {
            Layout.fillWidth: true
            BodyLargeText {
                text: headline
            }
            BodyMediumText {
                text: description
            }
        }
    }
}

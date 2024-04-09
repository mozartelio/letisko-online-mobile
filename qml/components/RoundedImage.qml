import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "./typography/title/text"

Item {
    required property url imageSource
    required property int imageWidth
    required property int imageHeight

    property int roundingRadius: 100

    implicitWidth: imageWidth
    implicitHeight: imageHeight
    Image {
        id: sourceItem
        width: parent.width
        height: parent.height
        source: imageSource
        verticalAlignment: Image.AlignVCenter
        anchors.fill: parent
        anchors.centerIn: parent
        visible: false
        smooth: true
    }

    MultiEffect {
        source: sourceItem
        anchors.fill: sourceItem
        maskEnabled: true
        maskSource: mask
    }

    Item {
        id: mask
        width: sourceItem.width
        height: sourceItem.height
        layer.enabled: true
        visible: false

        Rectangle {
            width: sourceItem.width
            height: sourceItem.height
            radius: roundingRadius
            color: __style.blackColor
        }
    }
}

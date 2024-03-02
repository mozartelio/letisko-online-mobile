import QtQuick
import QtQuick.Layouts
import "./typography/label"

Rectangle {
    id: drawerItem
    property string iconSource
    property string itemName

    // property int drawerWidth
    signal press

    color: "#00FFFFFF"
    radius: 100
    Layout.preferredHeight: 56
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight
    Layout.fillWidth: true
    Layout.fillHeight: false

    // Layout.alignment: Qt.AlignLeft
    Layout.alignment: Qt.AlignTop | Qt.AlignLeft | Qt.AnchorLeft | Qt.AnchorTop

    // Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft | Qt.AnchorLeft | Qt.AnchorTop
    Layout.margins: 0
    // Layout.leftMargin: 12
    // Layout.rightMargin: drawerItem.Layout.leftMargin
    // Layout.topMargin: 0
    // Layout.bottomMargin: drawerItem.Layout.topMargin

    // Layout.minimumWidth: (drawerWidth - 2 * drawerItem.Layout.leftMargin)
    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.color = '#E8DEF8'
            console.log("pressed")
        }
        onReleased: {
            parent.color = '#00FFFFFF'
            console.log("released")
        }
    }

    RowLayout {
        id: drawerItemRow
        layoutDirection: Qt.LeftToRight
        spacing: 12
        anchors {
            leftMargin: 16
            rightMargin: 24
            topMargin: 16
            bottomMargin: 16
            fill: parent
        }

        Image {
            id: icon
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft | Qt.AnchorLeft
            source: iconSource
        }

        LabelLargeProminent {
            id: text
            text: qsTr(itemName)
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft | Qt.AnchorLeft
        }
    }
}

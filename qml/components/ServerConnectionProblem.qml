import QtQuick
import QtQuick.Layouts
import "./typography/headline/text"

Rectangle {
    id: root
    color: __style.errorColor
    radius: 12
    visible: false
    implicitHeight: row.implicitHeight + row.anchors.margins * 2
    implicitWidth: row.implicitWidth + row.anchors.margins * 2

    RowLayout {
        id: row
        spacing: 10
        anchors {
            margins: 10
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        Image {
            id: icon
            width: __style.icon48
            height: __style.icon48r
            source: __style.warningIcon

            Layout.alignment: Qt.AlignLeft
        }

        HeadlineMediumText {
            text: qsTr("No connection to a server")
            color: __style.onPrimaryColor
            Layout.alignment: Qt.AlignRight
        }
    }

    Connections {
        target: serverConnectionChecker

        function onConnectionResult(isConnected) {
            if (isConnected === true) {
                console.log("connected to the server successfully")
            } else {

                console.log("DID NOT connected to the server successfully")
            }
            root.visible = !isConnected
        }
    }
}

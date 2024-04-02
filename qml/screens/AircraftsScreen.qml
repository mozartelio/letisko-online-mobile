import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: root

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    contentItem: ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: 17
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            leftMargin: 40
            rightMargin: 40
            topMargin: 8
            bottomMargin: 100
        }

        RowLayout {
            spacing: 50
            Layout.alignment: Qt.AlignHCenter
            SearchBar {
                Layout.alignment: Qt.AlignCenter
            }
            MaterialButton {
                contentText: "Filters"
                backgroundColor: __style.surfaceContainerLowColor
                imagePath: __style.settinsIcon
                onClicked: filterPopUp.open()
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            }
        }

        ScrollView {
            clip: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Layout.fillHeight: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true

            // ScrollBar
            Column {
                width: parent.width
                height: parent.height
                AircraftStrip {
                    serialNumber: "JDW35AXM"
                    imagePath: "../../assets/icons/default_plane_plug.png"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
                AircraftStrip {
                    serialNumber: "OEM84JDU"
                }
            }

            // ScrollBar.vertical: ScrollBar {}
        }
        // }
    }

    PopupParent {
        id: filterPopUp
    }
}

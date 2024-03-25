import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import "../components"

Page {
    id: root

    Material.theme: Material.Light
    background: Rectangle {
        color: "white"
    }

    contentItem: ColumnLayout {
        spacing: 17
        width: root.width
        height: root.height
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            leftMargin: 40
            rightMargin: 40
            topMargin: 8
            bottomMargin: 38
        }

        SearchBar {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }
        SortingBar {
            leftSectionHeader: "Creation time"
            leftSectionLeftButtonText: "Сlosest to farthest"
            leftSectionRightButtonText: "Farthest to closest"

            rigthSectionHeader: "Edited  time"
            rigthSectionLeftButtonText: "Сlosest to farthest"
            rigthSectionRightButtonText: "Farthest to closest"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            // Layout.fillHeight: true
            DocumentationStrip {
                documentName: "test_doc.pdf"
                createdByUser: "X"
            }
        }
    }
}

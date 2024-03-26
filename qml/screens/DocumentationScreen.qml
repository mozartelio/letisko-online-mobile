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

        ScrollView {

            clip: true
            spacing: 0
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Layout.fillHeight: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true

            Column {
                width: parent.width
                height: parent.height
                DocumentationStrip {
                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
                DocumentationStrip {

                    documentName: "test_doc.pdf"
                    createdByUser: "X"
                }
            }
        }
    }
}

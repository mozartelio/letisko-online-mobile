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

        SearchBar {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }
        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT

        ScrollView {
            id: mainColumn
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
            Column {
                id: innerColumn
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
        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
        // ListView {
        // }
    }
}

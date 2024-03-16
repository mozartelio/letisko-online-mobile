import QtQuick
import QtQuick.Controls

Page {
    Rectangle {
        color: "white"
        anchors.fill: parent

        ListModel {
            id: contactModel
            ListElement {
                name: "duties"
                image: "../../assets/icons/visibility_on.svg"
            }
            ListElement {
                name: "users"
                image: "../../assets/icons/visibility_on.svg"
            }
            ListElement {
                // id: listElement
                name: "documentation"
                image: "../../assets/icons/visibility_on.svg"
            }
        }

        Component {
            id: contactDelegate

            MouseArea {
                id: currItem
                width: grid.cellWidth
                height: grid.cellHeight
                anchors.margins: 5
                onClicked: {
                    console.log("test")
                    if (grid.currentIndex === index)
                        grid.currentIndex = -1
                    else
                        grid.currentIndex = index
                }
                Column {
                    anchors.fill: parent

                    Image {
                        source: image
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: name
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        GridView {
            id: grid
            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            model: contactModel
            currentIndex: -1
            cellWidth: 80
            cellHeight: 80
            highlight: Rectangle {
                color: "lightsteelblue"
                radius: 5
            }
            delegate: contactDelegate
            focus: true
        }
    }
}

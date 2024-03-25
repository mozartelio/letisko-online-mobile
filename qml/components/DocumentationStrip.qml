import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import "./typography/body/text"

Rectangle {
    id: root

    required property string documentName
    required property string createdByUser

    color: "#FFD8E4"
    implicitWidth: parent.width
    implicitHeight: mainColumn.implicitHeight + mainColumn.anchors.topMargin
                    + mainColumn.anchors.bottomMargin //100
    Material.theme: Material.Light

    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: root
                    color: "#D0BCFF"
                }
                when: mouseArea.pressed
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onPressed: {
            console.log("pressed")
        }
    }

    ColumnLayout {
        id: mainColumn

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            topMargin: 12
            bottomMargin: 12
            leftMargin: 31
            rightMargin: 24
        }

        Row {
            BodyLargeText {
                text: qsTr("Name: ")
            }
            BodyLargeText {
                text: documentName
                font.bold: true
            }
        }
        RowLayout {
            spacing: 100

            Row {
                BodyMediumText {
                    text: qsTr("Created by: ")
                    font.bold: true
                }
                BodyMediumText {
                    text: "info"
                    font.bold: true
                    color: "#6750A4"
                    MouseArea {
                        id: docAuthorMouseArea
                        anchors.fill: parent
                        onPressed: {
                            console.log("doc author pressed")
                        }
                    }
                }
            }

            Row {
                BodyMediumText {
                    text: qsTr("Created at: ")
                    font.bold: true
                }
                BodyMediumText {
                    text: "info"
                }
            }

            Row {
                BodyMediumText {
                    text: qsTr("Edited at: ")
                    font.bold: true
                }
                BodyMediumText {
                    text: "info"
                }
            }

            Row {
                BodyMediumText {
                    text: qsTr("Version: ")
                    font.bold: true
                }
                BodyMediumText {
                    text: "info"
                }
            }
        }
    }
    Rectangle {
        height: 1
        width: root.width
        color: "#CAC4D0"
        anchors {
            left: root.left
            right: root.right
            bottom: root.bottom
        }
    }
}

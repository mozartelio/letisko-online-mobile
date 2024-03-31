import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import "./typography/body/text"

Rectangle {
    id: root

    required property string serialNumber
    property url imagePath: ""

    color: __style.basicStripColor
    implicitWidth: parent.width
    implicitHeight: topRowWrapper.implicitHeight + topRowWrapper.anchors.topMargin
                    + topRowWrapper.anchors.bottomMargin //100

    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: root
                    color: __style.pressAccentColor
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

    RowLayout {
        id: topRowWrapper

        spacing: 20
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            topMargin: 12
            bottomMargin: 12
            leftMargin: 16
            rightMargin: 24
        }

        Image {
            id: aircraftImage
            source: imagePath
            verticalAlignment: Image.AlignVCenter
            visible: imagePath.toString() !== "" ? true : false
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.preferredWidth: 92
            Layout.preferredHeight: 92
            Layout.leftMargin: 15
        }

        ColumnLayout {
            spacing: 0
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            Row {
                BodyLargeText {
                    text: qsTr("Serial number: ")
                }
                BodyLargeText {
                    text: serialNumber
                    font.bold: true
                }
            }

            GridLayout {
                id: grid

                flow: GridLayout.LeftToRight
                columnSpacing: 180
                rowSpacing: 0
                columns: 2

                Layout.fillWidth: true

                StateGroup {
                    states: [
                        State {
                            when: window.width <= 600
                            PropertyChanges {
                                target: grid
                                columns: 1
                            }
                        },
                        State {
                            when: window.width > 600 && window.width <= 1150
                            PropertyChanges {
                                target: grid
                                columns: 2
                            }
                        },
                        State {
                            when: window.width > 1150
                            PropertyChanges {
                                target: grid
                                columns: 3
                            }
                        }
                    ]
                }

                Row {
                    BodyMediumText {
                        text: qsTr("Owner: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                        font.bold: true
                        color: __style.primaryColor
                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                console.log("aircraft owner pressed")
                            }
                        }
                    }
                }

                Row {
                    BodyMediumText {
                        text: qsTr("Name: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    BodyMediumText {
                        text: qsTr("Date of last maintainance: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                        font.bold: true
                        color: __style.primaryColor
                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                console.log("Date of last maintainance pressed")
                            }
                        }
                    }
                }

                Row {
                    BodyMediumText {
                        text: qsTr("Total time flown: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: " info... hours"
                    }
                }

                Row {
                    // Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Aircraft type: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    // Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Aircraft class: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    // Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Aircraft category: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    // Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Flight rules: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    // Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("ICAO wake tubulence category: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }
            }
        }
    }

    Popup {
        id: filterPopUp
    }

    Rectangle {
        height: 1
        width: root.width
        color: __style.outlineVariant
        anchors {
            left: root.left
            right: root.right
            bottom: root.bottom
        }
    }
}

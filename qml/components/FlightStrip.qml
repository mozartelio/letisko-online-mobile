import QtQuick
import QtQuick.Layouts
import "./typography/body/text"

Rectangle {
    id: root
    required property string callsign
    required property int status

    property bool isExpanded: false

    color: "#FEF7FF"
    height: (grid.columns === 1) ? 185 : (grid.columns === 2) ? 165 : 130
    width: parent.width

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
        width: parent.width
        spacing: 8

        Rectangle {
            id: mainInfoRectangle
            color: "#FFD8E4" //"red"
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40

            RowLayout {
                spacing: 30
                width: parent.width
                height: parent.height
                anchors {
                    leftMargin: 20
                    fill: parent
                }

                RowLayout {
                    spacing: 7
                    Layout.alignment: Qt.AlignVCenter

                    //TODO: create TEXT as component
                    Text {
                        Layout.preferredWidth: contentWidth
                        font.family: "Roboto"
                        font.weight: 700
                        font.pixelSize: 16
                        font.letterSpacing: 0.5
                        lineHeightMode: Text.FixedHeight
                        lineHeight: 24
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        text: callsign
                    }

                    FlightStatus {
                        status: root.status
                    }
                }

                RowLayout {
                    spacing: 150

                    Row {
                        BodyLargeText {
                            text: qsTr("Departure: ")
                            font.bold: true
                        }
                        BodyLargeText {
                            text: "info"
                        }
                    }

                    Row {
                        BodyLargeText {
                            text: qsTr("Arrival: ")
                            font.bold: true
                        }
                        BodyLargeText {
                            text: "info"
                        }
                    }

                    Row {
                        BodyLargeText {
                            text: qsTr("Plane name: ")
                            font.bold: true
                        }
                        BodyLargeText {
                            text: "info"
                        }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.leftMargin: 16
            Layout.rightMargin: 24
            Layout.bottomMargin: 12

            GridLayout {
                id: grid
                Layout.fillWidth: true
                flow: GridLayout.LeftToRight
                columnSpacing: 39
                rowSpacing: 0
                columns: 2
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
                    Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Aircraft type: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("ICAO wake tubulence category: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Aircraft class: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Aircraft category: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }

                Row {
                    Layout.preferredWidth: 362
                    BodyMediumText {
                        text: qsTr("Flight rules: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }
            }

            Row {
                Layout.preferredWidth: 362
                BodyMediumText {
                    text: qsTr("Description: ")
                    font.bold: true
                }
                BodyMediumText {
                    text: "info"
                }
            }
        }
    }

    Image {

        anchors {
            right: root.right
            verticalCenter: root.verticalCenter
            rightMargin: 50
        }

        width: 40
        height: 40
        source: "../../assets/icons/arrow_right_40px.svg"
        verticalAlignment: Image.AlignVCenter
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

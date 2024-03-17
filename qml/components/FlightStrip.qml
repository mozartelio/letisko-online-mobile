import QtQuick
import QtQuick.Layouts
import "./typography/body/text"

Rectangle {
    id: root
    property string callsign
    property int status

    color: "#FEF7FF"
    height: (grid.columns === 1) ? 185 : (grid.columns === 2) ? 165 : 130
    width: parent.width

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onPressed: {
            console.log("pressed")
        }
    }
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

    RowLayout {
        anchors {
            leftMargin: 16
            rightMargin: 24
            topMargin: 12
            bottomMargin: 12
            top: root.top
            left: root.left
            right: root.right
        }
        spacing: 16

        ColumnLayout {

            Layout.preferredWidth: contentWidth
            RowLayout {
                spacing: 7

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
                    status: status
                }
            }
            GridLayout {
                id: grid
                Layout.fillWidth: true
                // Layout.fillHeight: true
                flow: GridLayout.LeftToRight
                columnSpacing: 39
                rowSpacing: 20
                columns: 2
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

                Item {
                    Layout.preferredWidth: 362
                    // Layout
                    Row {
                        BodyMediumText {
                            text: qsTr("Aircraft type: ")
                            font.bold: true
                        }
                        BodyMediumText {
                            text: "info"
                        }
                    }
                }
                Item {
                    Layout.preferredWidth: 362
                    Row {
                        BodyMediumText {
                            text: qsTr("ICAO wake tubulence category: ")
                            font.bold: true
                        }
                        BodyMediumText {
                            text: "info"
                        }
                    }
                }
                Item {
                    Layout.preferredWidth: 362
                    Row {
                        BodyMediumText {
                            text: qsTr("Aircraft class: ")
                            font.bold: true
                        }
                        BodyMediumText {
                            text: "info"
                        }
                    }
                }
                Item {
                    Layout.preferredWidth: 362
                    Row {
                        BodyMediumText {
                            text: qsTr("Aircraft category: ")
                            font.bold: true
                        }
                        BodyMediumText {
                            text: "info"
                        }
                    }
                }
                Item {
                    Layout.preferredWidth: 362
                    Row {
                        BodyMediumText {
                            text: qsTr("Flight rules: ")
                            font.bold: true
                        }
                        BodyMediumText {
                            text: "info"
                        }
                    }
                }
            }
            Item {
                Layout.topMargin: 20
                Layout.preferredWidth: 362
                Row {
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
            width: 40
            height: 40
            source: "../../assets/icons/arrow_right_40px.svg"
            verticalAlignment: Image.AlignVCenter
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

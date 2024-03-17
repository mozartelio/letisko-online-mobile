import QtQuick
import QtQuick.Layouts
import "./typography/body/text"

Rectangle {
    id: root
    property string callsign
    property int status

    color: "#FEF7FF"
    height: 150
    width: parent.width * 0.68

    MouseArea {
        anchors.fill: root
        onPressed: {
            console.log("pressed")
            root.color = "#D0BCFF"
        }
        onReleased: root.color = "#FEF7FF"
    }

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
                Layout.fillWidth: true

                // Layout.fillHeight: true
                flow: GridLayout.LeftToRight
                columnSpacing: 39
                rowSpacing: 20
                columns: 2

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

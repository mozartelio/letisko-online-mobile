import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "./typography/body/text"

Item {
    id: root
    required property string callsign
    required property int status

    property bool isExpanded: false //true

    width: parent.width
    implicitHeight: column.implicitHeight
    Material.theme: Material.Light

    StateGroup {
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: flightDetails
                    color: __style.pressAccentColor
                }
                when: mouseArea.pressed
            }
        ]
    }
    ColumnLayout {
        id: column
        width: parent.width
        spacing: 0

        Rectangle {
            id: backgroungRectangle
            color: __style.accentedStripColor
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 50

            RowLayout {
                width: parent.width //- 40
                height: parent.height
                spacing: 30

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom

                    leftMargin: 20
                    rightMargin: 30
                }

                Button {
                    padding: 0
                    display: AbstractButton.IconOnly
                    icon {
                        width: 12
                        height: 12
                        color: __style.transparentColor
                        source: __style.arrowDropDownMediumIcon
                    }
                    Layout.margins: 0
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

                    onClicked: {
                        console.log("pressed")
                        isExpanded = !isExpanded
                    }
                }

                RowLayout {
                    spacing: 7
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.preferredWidth: (1 / 4) * backgroungRectangle.width

                    //TODO: create TEXT as component
                    Text {
                        font.family: "Roboto"
                        font.weight: 700
                        font.pixelSize: 16
                        font.letterSpacing: 0.5
                        lineHeightMode: Text.FixedHeight
                        lineHeight: 24
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        text: callsign
                        Layout.preferredWidth: contentWidth
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    }

                    FlightStatus {
                        status: root.status
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    }
                }

                RowLayout {
                    spacing: 150
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    Layout.fillWidth: true
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

                Button {

                    display: AbstractButton.IconOnly
                    icon {
                        width: __style.icon24
                        height: __style.icon24
                        color: __style.transparentColor
                        source: __style.editIcon
                    }
                    Layout.margins: 0
                    padding: 0
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                }
            }
        }

        Rectangle {
            id: flightDetails
            color: __style.basicStripColor
            visible: isExpanded
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: (grid.columns == 1) ? 135 : (grid.columns == 2) ? 115 : 80

            MouseArea {
                id: mouseArea
                anchors.fill: flightDetails
                onPressed: {
                    console.log("pressed")
                }
            }
            ColumnLayout {
                width: parent.width
                height: parent.Layout.preferredHeight
                spacing: 0
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    leftMargin: 16
                    rightMargin: 24
                    topMargin: 12
                    bottomMargin: 12
                }

                GridLayout {
                    id: grid
                    flow: GridLayout.LeftToRight
                    columnSpacing: 39
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

                    Row {
                        Layout.preferredWidth: 362
                        BodyMediumText {
                            text: qsTr("Height level: ")
                            font.bold: true
                        }
                        BodyMediumText {
                            text: "100"
                        }
                        BodyMediumText {
                            text: " measurement units"
                        }
                    }
                }

                Row {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 32
                    BodyMediumText {
                        text: qsTr("Description: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: "info"
                    }
                }
            }
            Image {
                width: __style.icon40
                height: __style.icon40
                source: __style.arrowRightIcon
                verticalAlignment: Image.AlignVCenter

                anchors {
                    right: flightDetails.right
                    verticalCenter: flightDetails.verticalCenter
                    rightMargin: 50
                }
            }
        }
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

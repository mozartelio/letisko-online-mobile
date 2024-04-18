import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import "./typography/body/text"

Rectangle {
    id: root

    required property string serialNumber
    required property double totalTimeFlown
    required property string timeUnitName
    required property string registrationState
    required property string aircraftType
    required property string flightRules
    required property string planeName
    required property string icaoWakeTurbulenceCategory

    property string ownerName
    required property string aircraftCategory
    required property string aircraftClass
    required property date lastMaintainance
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
            // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
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
            source: root.imagePath
            verticalAlignment: Image.AlignVCenter
            visible: root.imagePath.toString() !== "" ? true : false
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
                    text: root.serialNumber
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
                    visible: root.ownerName !== null && root.ownerName !== ""
                    BodyMediumText {
                        text: qsTr("Owner: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: root.ownerName
                        font.bold: true
                        color: __style.primaryColor
                        MouseArea {
                            // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                            anchors.fill: parent
                            onPressed: {
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
                        text: root.planeName
                    }
                }

                Row {
                    visible: {
                        // Check if lastMaintainance is a valid date
                        var date = new Date(root.lastMaintainance)
                        return !isNaN(date.getTime())
                    }
                    BodyMediumText {
                        text: qsTr("Date of last maintainance: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: Qt.formatDateTime(root.lastMaintainance,
                                                "hh:mm dd.MM.yyyy")
                        font.bold: true
                        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT: show all the dates
                        // color: __style.primaryColor
                        MouseArea {
                            anchors.fill: parent
                            onPressed: {

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
                        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT:  timeUnitName translation
                        text: Number(root.totalTimeFlown).toFixed(
                                  2) + " " + qsTr(root.timeUnitName)
                    }
                }

                Row {
                    BodyMediumText {
                        text: qsTr("Aircraft type: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: root.aircraftType
                    }
                }

                Row {
                    visible: root.aircraftClass !== null
                             && root.aircraftClass !== ""
                    BodyMediumText {
                        text: qsTr("Aircraft class: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: root.aircraftClass
                    }
                }

                Row {
                    visible: root.aircraftCategory !== null
                             && root.aircraftCategory !== ""
                    BodyMediumText {
                        text: qsTr("Aircraft category: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: root.aircraftCategory
                    }
                }

                Row {
                    BodyMediumText {
                        text: qsTr("Flight rules: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT:  flightRules translation
                        text: qsTr(flightRules)
                    }
                }

                Row {
                    BodyMediumText {
                        text: qsTr("ICAO wake turbulence category: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        text: root.icaoWakeTurbulenceCategory
                    }
                }
                Row {
                    BodyMediumText {
                        text: qsTr("State of registration: ")
                        font.bold: true
                    }
                    BodyMediumText {
                        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT:  registrationState translation
                        text: root.registrationState
                    }
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

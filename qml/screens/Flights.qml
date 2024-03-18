import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../components/divider/"
import "../components/"
import "../components/typography/title/text"
import "../components/typography/body/text"

Page {
    id: root
    background: Rectangle {
        color: "white" //"salmon"
    }

    // FlightStatus {
    //     status: FlightStatus.Status.Pending
    // }
    contentItem: ColumnLayout {
        id: column
        width: root.width
        height: root.height
        spacing: 10
        anchors {
            left: root.left
            right: root.right
            top: root.top
            bottom: root.bottom
            margins: 40
        }

        SearchBar {
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
            Layout.preferredHeight: 56
            Layout.preferredWidth: column.width
        }

        ColumnLayout {
            id: ongoingFlightHead
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 77
            Layout.preferredWidth: parent.width
            spacing: 4
            Rectangle {
                color: "#CAC4D0"
                Layout.preferredHeight: 2
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.preferredWidth: parent.width
                // anchors {
                //     top: parent.top
                //     left: parent.left
                //     right: parent.right
                // }
            }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.preferredWidth: parent.width
                spacing: 25
                TitleLargeText {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.preferredHeight: contentHeight
                    Layout.preferredWidth: contentWidth
                    text: qsTr("Ongoing flights")
                }

                Rectangle {
                    id: mainToolBarBox
                    Layout.alignment: Qt.AlignVCenter
                    color: "#FEF7FF"
                    Layout.preferredWidth: 466
                    Layout.preferredHeight: 77

                    Rectangle {
                        id: departure
                        width: mainToolBarBox.Layout.preferredWidth / 2
                        height: 24
                        color: "#7A7289"
                        anchors {
                            top: mainToolBarBox.top
                            left: mainToolBarBox.left
                        }
                        BodySmallText {
                            text: qsTr("Departure time")
                            color: "white"
                            anchors.centerIn: parent
                        }
                    }
                    Rectangle {
                        id: arrival
                        width: mainToolBarBox.Layout.preferredWidth / 2
                        height: 24
                        color: "#EADDFF"
                        anchors {
                            top: mainToolBarBox.top
                            right: mainToolBarBox.right
                        }
                        BodySmallText {
                            text: qsTr("Arrival time")
                            color: "#322F35"
                            anchors.centerIn: parent
                        }
                    }

                    RowLayout {
                        spacing: 0
                        height: parent.Layout.preferredHeight
                        anchors {
                            top: parent.top
                            bottom: parent.bottom
                            left: parent.left
                            right: parent.right
                        }

                        ButtonGroup {
                            id: filterButtonGroup
                        }

                        FilterButton {
                            id: closestToFarthestDeparture
                            contentText: qsTr("Сlosest to farthest")
                            ButtonGroup.group: filterButtonGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }
                        FilterButton {
                            id: farthestToClosestDeparture
                            contentText: qsTr("Farthest to closest")
                            ButtonGroup.group: filterButtonGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }

                        ToolSeparator {
                            padding: -1
                            Layout.alignment: Qt.AlignBottom
                            contentItem: Rectangle {
                                implicitWidth: 1
                                implicitHeight: 45
                                color: "#c3c3c3"
                            }
                        }
                        FilterButton {
                            id: closestToFarthestArrival
                            contentText: qsTr("Сlosest to farthest")
                            ButtonGroup.group: filterButtonGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }
                        FilterButton {
                            id: farthestToClosestArrival
                            contentText: qsTr("Farthest to closest")
                            ButtonGroup.group: filterButtonGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }
                    }
                }
            }
        }

        Column {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 356
            Layout.preferredWidth: parent.width

            FlightStrip {
                callsign: "AWS152ALPHA"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            FlightStrip {
                callsign: "AWS152ALPHA"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import "../components/divider/"
import "../components/"
import "../components/typography/label/text"
import "../components/typography/title/text"
import "../components/typography/body/text"

Page {
    id: root
    Material.theme: Material.Light
    background: Rectangle {
        color: "white"
    }

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
                    Layout.preferredWidth: 467
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
                            id: sortingButtonsGroup
                        }

                        SortingButton {
                            id: closestToFarthestDeparture
                            contentText: qsTr("Сlosest to farthest")
                            ButtonGroup.group: sortingButtonsGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }
                        SortingButton {
                            id: farthestToClosestDeparture
                            contentText: qsTr("Farthest to closest")
                            ButtonGroup.group: sortingButtonsGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }

                        SortingButton {
                            id: closestToFarthestArrival
                            contentText: qsTr("Сlosest to farthest")
                            ButtonGroup.group: sortingButtonsGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }
                        SortingButton {
                            id: farthestToClosestArrival
                            contentText: qsTr("Farthest to closest")
                            ButtonGroup.group: sortingButtonsGroup
                            Layout.alignment: Qt.AlignBottom
                            Layout.preferredWidth: mainToolBarBox.Layout.preferredWidth / 4
                            Layout.preferredHeight: mainToolBarBox.Layout.preferredHeight
                                                    - departure.height
                        }
                    }
                }

                Button {
                    id: filterButton
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 114
                    Layout.preferredHeight: 40

                    background: Rectangle {
                        id: back
                        anchors {
                            fill: parent
                            centerIn: filterButton
                        }
                        height: filterButton.Layout.preferredHeight
                        width: filterButton.Layout.preferredWidth
                        color: "#F7F2FA"
                        radius: 100
                    }

                    states: [
                        State {
                            name: "pressed"
                            PropertyChanges {
                                target: back
                                color: "#D0BCFF"
                            }
                            when: filterButton.pressed
                        }
                    ]
                    contentItem: RowLayout {
                        spacing: 8
                        anchors {
                            fill: filterButton
                            centerIn: filterButton
                            leftMargin: 24
                            rightMargin: 24
                            topMargin: 10
                            bottomMargin: 10
                        }
                        LabelLargeText {
                            text: "Filters"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            verticalAlignment: Image.AlignVCenter
                        }
                        Image {
                            width: 22
                            height: 24
                            source: "../../assets/icons/settings.svg"
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            verticalAlignment: Image.AlignVCenter
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

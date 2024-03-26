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

    property bool arePasstFlightsRequested: false
    Material.theme: Material.Light
    background: Rectangle {
        color: "white"
    }

    contentItem: ColumnLayout {
        id: column
        width: parent.width
        height: parent.height
        spacing: 8
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: 40
            rightMargin: 40
            topMargin: 8
            bottomMargin: 38
        }

        SearchBar {
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
        }

        ColumnLayout {
            id: ongoingFlightHead
            spacing: 4
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 77
            Layout.preferredWidth: parent.width

            Rectangle {
                color: "#CAC4D0"
                Layout.preferredHeight: 2
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.preferredWidth: parent.width
            }
            RowLayout {
                spacing: 25
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.preferredWidth: parent.width

                TitleLargeText {
                    text: qsTr("Ongoing flights")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.preferredHeight: contentHeight
                    Layout.preferredWidth: contentWidth
                }

                SortingBar {
                    id: mainToolBarBox
                    leftSectionHeader: "Departure time"
                    leftSectionLeftButtonText: "Сlosest to farthest"
                    leftSectionRightButtonText: "Farthest to closest"

                    rigthSectionHeader: "Arrival time"
                    rigthSectionLeftButtonText: "Сlosest to farthest"
                    rigthSectionRightButtonText: "Farthest to closest"
                }

                MaterialButton {
                    contentText: "Filters"
                    backgroundColor: "#F7F2FA"
                    imagePath: "../../assets/icons/settings.svg"
                    onClicked: filterPopUp.open()
                }
            }
        }

        ScrollView {
            spacing: 0
            clip: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 356 //parent.height
            Layout.preferredWidth: parent.width
            Layout.topMargin: 8

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true

            Column {
                id: flightsColumn
                width: parent.width
                height: parent.height
                FlightStrip {
                    callsign: "AWS152ALPHA"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Denied
                    Layout.fillWidth: true
                    // Layout.preferredHeight: contentItem.height//356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "Atlant32"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Pending
                    Layout.fillWidth: true
                    // Layout.preferredHeight: implicitContentHeight //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
                FlightStrip {
                    callsign: "RMSTN1"
                    // anchors.horizontalCenter: parent.horizontalCenter
                    status: FlightStatus.Status.Confirmed
                    Layout.fillWidth: true
                    // Layout.preferredHeight: 50 //356
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
            }
        }

        MouseArea {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 77
            Layout.preferredWidth: parent.width

            onPressed: arePasstFlightsRequested = !arePasstFlightsRequested
            ColumnLayout {
                id: pastFlightHead
                anchors.fill: parent

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
                    Layout.rightMargin: 7
                    // Layout.leftMargin: 7
                    spacing: 25
                    TitleLargeText {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.preferredHeight: contentHeight
                        Layout.preferredWidth: contentWidth
                        text: qsTr("Past flights")
                    }

                    Image {
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        width: 40
                        height: 40
                        source: arePasstFlightsRequested ? "../../assets/icons/arrow_drop_up_big.svg" : "../../assets/icons/arrow_drop_down_big.svg"
                        verticalAlignment: Image.AlignVCenter
                    }
                }
            }
        }
    }

    FlightFilterPopUp {
        id: filterPopUp
    }
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import UserAppSettings
import com.letiskoonline.UserController
import com.letiskoonline.FlightsController
import "../components/"
import "../components/typography/label/text"
import "../components/typography/title/text"
import "../components/typography/body/text"

Page {
    id: root

    property bool arePasstFlightsRequested: false

    background: Rectangle {
        color: __style.onPrimaryColor
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
            //do not set - causes bugs
            // bottomMargin: 38
        }

        SearchBar {
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
            onTextChanged: {
                flightsFilterProxyModel.setFilterString(text)
            }
        }

        Column {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 100
            Layout.preferredWidth: parent.width

            Rectangle {
                color: __style.outlineVariant
                height: 2
                width: parent.width
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.preferredWidth: parent.width
            }

            RowLayout {
                spacing: 25
                width: parent.width
                height: 20
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillWidth: true

                ColumnLayout {
                    spacing: 10
                    Layout.preferredWidth: 130
                    Layout.maximumWidth: 130
                    height: parent.height

                    TitleLargeText {
                        text: qsTr("Flights:")
                        Layout.leftMargin: 20
                        Layout.topMargin: 10                       
                    }
                    Button {
                        id: control
                        text: UserAppSettings.isFlightsEditingLocked ? qsTr(
                                                                           "Unlock editing") : qsTr(
                                                                           "Lock editing")
                        checkable: true
                        checked: true
                        display: AbstractButton.TextBesideIcon
                        background: Rectangle {
                            radius: 100
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            color: control.down ? "#d0d0d0" : "#e0e0e0"
                        }
                        icon {
                            width: __style.icon24
                            height: __style.icon24
                            source: UserAppSettings.isFlightsEditingLocked ? __style.unlockIcon : __style.lockIcon
                        }
                        onClicked: {
                            UserAppSettings.isFlightsEditingLocked
                                    = !UserAppSettings.isFlightsEditingLocked
                        }
                    }
                }

                FlightsSortingBar {
                    id: flightsSortingBar
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.leftMargin: 40
                    Layout.rightMargin: 250
                }

                // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
                // Item {
                //     Layout.fillWidth: true

                //     // Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                //     MaterialButton {
                //         id: filtersButton
                //         contentText: qsTr("Filters")
                //         backgroundColor: __style.surfaceContainerLowColor
                //         imagePath: __style.settinsIcon
                //         anchors {
                //             verticalCenter: parent.verticalCenter
                //             right: parent.right
                //             rightMargin: 30
                //         }
                //         onClicked: filterPopUp.open()
                //     }
                // }
            }
        }

        BusyIndicator {
            running: FlightsController.isLoadingFlights
            visible: FlightsController.isLoadingFlights
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
        }

        ScrollView {
            spacing: 0
            clip: true
            visible: !FlightsController.isLoadingFlights
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width
            Layout.topMargin: 15
            Layout.bottomMargin: 100
            Layout.fillHeight: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true

            ListView {
                id: view
                model: flightsFilterProxyModel              
                width: parent.width
                anchors {
                    fill: parent
                }
                cacheBuffer: 3
                spacing: 0

                // must to use Item as proxy because of problem described here
                // https://forum.qt.io/post/741302
                delegate: Item {
                    id: delegateItem
                    width: view.width
                    height: flightStrip.implicitHeight
                    FlightStrip {
                        id: flightStrip
                        width: parent.width
                        callsign: callsignData
                        departureAirport: departureAirportData
                        arrivalAirport: arrivalAirportData
                        flightStatus: flightStatusData
                        departureTime: departureTimeData
                        arrivalTime: arrivalTimeData
                        maxHeight: maxHeightData
                        maxHeightMeasureUnits: maxHeightMeasureUnitsData
                        flightRequestId: flightRequestIdData
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            fill: parent
                        }
                    }
                }
            }
        }

        // #TODO: RELEASE_ON_FURURE_API_IMPROVEMENT
        // MouseArea {
        //     Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //     Layout.preferredHeight: 77
        //     Layout.preferredWidth: parent.width

        //     onPressed: arePasstFlightsRequested = !arePasstFlightsRequested
        //     ColumnLayout {
        //         anchors.fill: parent

        //         spacing: 4

        //         Rectangle {
        //             color: __style.outlineVariant
        //             Layout.preferredHeight: 2
        //             Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //             Layout.preferredWidth: parent.width
        //         }
        //         RowLayout {
        //             Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //             Layout.preferredWidth: parent.width
        //             Layout.rightMargin: 7
        //             // Layout.leftMargin: 7
        //             spacing: 25
        //             TitleLargeText {
        //                 Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        //                 Layout.preferredHeight: contentHeight
        //                 Layout.preferredWidth: contentWidth
        //                 text: qsTr("Past flights")
        //             }

        //             Image {
        //                 Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //                 width: __style.icon40
        //                 height: __style.icon40
        //                 source: arePasstFlightsRequested ? __style.arrowDropUpBigIcon : __style.arrowDropDownBigIcon
        //                 verticalAlignment: Image.AlignVCenter
        //             }
        //         }
        //     }
        // }
    }

    // FlightFilterPopUp {
    //     id: filterPopUp
    // }
    Component.onCompleted: {
        if (FlightsController !== null) {
            FlightsController.setIsActiveScreen(true)
        }
    }

    Component.onDestruction: {
        if (FlightsController !== null) {
            FlightsController.setIsActiveScreen(false)
        }
        // removes a filter and shows all items in the model
        flightsFilterProxyModel.setFilterString("")
    }
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import com.letiskoonline.UserController
import com.letiskoonline.FlightsController
import "../components/divider/"
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
            bottomMargin: 38
        }

        SearchBar {
            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
            onTextChanged:

            // FlightsController.getFlightsModel().getFilterProxyModel(
            //             ).setFilterString(
            //             text) //filterModel.setFilterString(text)
            {
            }
        }

        ColumnLayout {
            id: ongoingFlightHead
            spacing: 4
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 77
            Layout.preferredWidth: parent.width

            Rectangle {
                color: __style.outlineVariant
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
                    onValueChanged:

                    // FlightsController.getFlightsModel().getFilterProxyModel(
                    //             ).setSortOrder(
                    //             checked) //filterModel.setSortOrder(checked)
                    {
                    }
                }

                MaterialButton {
                    contentText: "Filters"
                    backgroundColor: __style.surfaceContainerLowColor
                    imagePath: __style.settinsIcon
                    onClicked: filterPopUp.open()
                }
            }
        }

        ScrollView {
            id: scrollView
            spacing: 0 // Adjust the spacing value as per your requirement
            clip: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredHeight: 356 //parent.height
            Layout.preferredWidth: parent.width
            Layout.topMargin: 8

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true

            ListView {
                id: view
                model: FlightsController.getFlightsModel().getFilterProxyModel
                //(FlightsController.getFlightsModel()).getFilterProxyModel()
                //filterModel
                width: parent.width
                height: parent.height
                anchors.fill: parent
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
                        // height: 30
                        callsign: callsignData
                        planeName: planeNameData
                        flightStatus: flightStatusData
                        departureTime: departureTimeData //Qt.formatDateTime(departureTimeData, "hh:mm dd.MM.yyyy")
                        arrivalTime: arrivalTimeData //Qt.formatDateTime(arrivalTimeData, "hh:mm dd.MM.yyyy")
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            fill: parent
                        }
                    }
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
                    color: __style.outlineVariant
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
                        width: __style.icon40
                        height: __style.icon40
                        source: arePasstFlightsRequested ? __style.arrowDropUpBigIcon : __style.arrowDropDownBigIcon
                        verticalAlignment: Image.AlignVCenter
                    }
                }
            }
        }
    }

    FlightFilterPopUp {
        id: filterPopUp
    }

    Component.onCompleted: {
        // var flightsController = flightsController //userController.getFlightsController()
        if (FlightsController !== null) {
            FlightsController.loadFlightsOnTimer();
        } else {
            console.log("FlightsController is not initialized yet.");
        }

        // UserController.getFlightsController().loadFlightsOnTimer()
        console.log("called:  FlightsController.getFlightsController().loadFlightsOnTimer(); ");
        // console.log("FlightsController.getFlightsModel().getFilterProxyModel()  //filterModel:");
        // console.log(FlightsController.getFlightsModel().getFilterProxyModel()  //filterModel.toString());
    }

    Component.onDestruction: {
        // var flightsController = flightsController //userController.getFlightsController()
        if (FlightsController !== null) {
            FlightsController.fligthScreenClosed();
        } else {
            console.log("FlightsController is not initialized yet.");
        }
        console.log("FlightsScreen was closed");
    }
}

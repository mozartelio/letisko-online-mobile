import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.letiskoonline.AircraftsController
import "../components"

Page {
    id: root

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    contentItem: ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: 17
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            leftMargin: 40
            rightMargin: 40
            topMargin: 8
            bottomMargin: 100
        }

        RowLayout {
            spacing: 50
            Layout.alignment: Qt.AlignHCenter
            SearchBar {
                Layout.alignment: Qt.AlignCenter
                onTextChanged: {
                    aircraftsFilterProxyModel.setFilterString(text)
                }
            }
            MaterialButton {
                contentText: "Filters"
                backgroundColor: __style.surfaceContainerLowColor
                imagePath: __style.settinsIcon
                onClicked: filterPopUp.open()
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            }
        }

        BusyIndicator {
            running: AircraftsController.isLoadingAircrafts
            visible: AircraftsController.isLoadingAircrafts
            Layout.alignment: Qt.AlignCenter
        }

        //TODO: change to flickable and ScrollBar
        ScrollView {
            clip: true
            visible: !AircraftsController.isLoadingAircrafts
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Layout.fillHeight: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true

            ListView {
                id: view
                model: aircraftsFilterProxyModel
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
                    height: aircraftStrip.implicitHeight
                    AircraftStrip {
                        id: aircraftStrip
                        width: parent.width
                        // height: 30
                        serialNumber: serialNumberData
                        totalTimeFlown: totalTimeFlownData
                        timeUnitName: timeUnitNameData
                        registrationState: registrationStateData
                        aircraftType: aircraftTypeData
                        flightRules: flightRulesData
                        planeName: planeNameData
                        icaoWakeTurbulenceCategory: icaoWakeTurbulenceCategoryData

                        ownerName: ownerNameData
                        aircraftCategory: aircraftCategoryData
                        aircraftClass: aircraftClassData
                        lastMaintainance: lastMaintainanceData
                        imagePath: imagePathData

                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            fill: parent
                        }
                    }
                }
            }
        }
    }

    //TODO:
    PopupParent {
        id: filterPopUp
    }

    Component.onCompleted: {
        if (AircraftsController !== null) {
            AircraftsController.setIsActiveScreen(true)
            console.log("called:  AircraftsController.setIsActiveScreen(true); ")
        } else {
            console.log("AircraftsController is not initialized yet.")
        }
        console.log("AircraftsScreen was opened")
    }

    Component.onDestruction: {
        if (AircraftsController !== null) {
            AircraftsController.setIsActiveScreen(false)
        } else {
            console.log("AircraftsController is not initialized yet.")
        }
        console.log("AircraftsScreen was closed")
    }
}

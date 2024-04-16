import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./typography/headline/text"
import "./typography/body/text"
import "./typography/label/text"
import "./typography/title/text"

/**
states: pending, dennied....
flight_rules:
aircraft_category
aircraft_class
aircraft_type
icao_w_turbulence_categories
**/
PopupParent {
    id: root
    width: 350
    height: 500

    content: Column {
        id: contentColumn
        width: parent.width
        height: parent.height

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            fill: parent
        }
        spacing: 0

        HeadlineSmallText {
            id: filtersHeader
            horizontalAlignment: Text.AlignLeft
            width: parent.width
            text: qsTr("Filters")
            padding: 24
        }

        // ListView {
        //     id: fligtRulesFilters
        //     width: parent.width
        //     // height: parent.height
        //     model: fligtRulesModel

        //     // property string expandedSection: ""
        //     delegate: listdelegate
        //     // section.: "sssssss"
        //     // section.property: "type"
        //     // section.criteria: ViewSection.FullString
        //     // section.delegate: sectionHeader
        // }
        Item {
        }

        Item {
            id: filtersSections
            width: parent.width
            clip: true
            height: parent.height
            visible: false

            ListModel {
                id: filtersModel
                ListElement {
                    name: "Approved"
                    type: "Status"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "Pending"
                    type: "Status"
                    checked: false
                    aVisible: false
                }
                ListElement {
                    name: "Denied"
                    type: "Status"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 1"
                    type: "Airctaft type"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 2"
                    type: "Airctaft type"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 3"
                    type: "Airctaft type"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type1"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type2"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type3"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type4"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type5"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type6"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type67"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft type66"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft tyQWEpe63"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft stQWEype63"
                    checked: true
                    aVisible: false
                }
                ListElement {
                    name: "type 4"
                    type: "Airctaft styWQEWRpe63"
                    checked: true
                    aVisible: false
                }
            }

            ListView {
                id: listing
                width: parent.width
                height: parent.height
                model: filtersModel

                property string expandedSection: ""

                delegate: listdelegate

                section.property: "type"
                section.criteria: ViewSection.FullString
                section.delegate: sectionHeader
            }

            Component {
                id: sectionHeader

                // property var headerCheckboxGroupId: sectionElementsGroup
                Rectangle {
                    id: sectionHeaderRect
                    property bool isExpanded: false
                    property string currentExpandedSection: ListView.view.expandedSection
                    width: parent.width
                    color: __style.transparentColor
                    height: 40

                    anchors {
                        leftMargin: 16
                        rightMargin: 16
                    }
                    onCurrentExpandedSectionChanged: {
                        if (currentExpandedSection === section)
                            isExpanded = true;
                        else
                            isExpanded = false;
                    }

                    onIsExpandedChanged: {
                        if (isExpanded) {
                            ListView.view.expandedSection = section;
                        }
                        // else
                        //     color = __style.transparentColor
                        for (var i = 0; i < filtersModel.count; i++) {
                            var item = filtersModel.get(i);
                            if (section === item.type)
                                item.aVisible = sectionHeaderRect.isExpanded;
                        }
                    }

                    // ButtonGroup {
                    //     id: sectionElementsGroup
                    //     exclusive: false
                    //     checkState: sectionBox.checkState
                    // }
                    ColumnLayout {
                        anchors {
                            fill: parent
                        }
                        spacing: 0

                        Rectangle {
                            id: sectionDivider
                            height: 3
                            width: parent.width
                            Layout.fillWidth: true
                            color: __style.outlineVariant
                            Layout.alignment: Qt.AlignTop
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.preferredWidth: parent.width
                            Layout.fillWidth: true
                            Layout.rightMargin: 7

                            // Layout.leftMargin: 15
                            // CheckBox {
                            //     id: sectionBox
                            //     checkState: sectionElementsGroup.checkState
                            // }
                            TitleMediumText {
                                id: sectionHeaderText
                                text: section
                                Layout.alignment: Qt.AlignVCenter | Text.AlignLeft
                            }
                            Image {
                                id: sectionImage
                                Layout.preferredWidth: 10
                                Layout.preferredHeight: 10
                                Layout.alignment: Qt.AlignVCenter | Text.AlignRight
                                source: isExpanded ? __style.arrowDropUpMediumIcon : __style.arrowDropDownMediumIcon
                                verticalAlignment: Image.AlignVCenter
                                horizontalAlignment: Image.AlignRight
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            sectionHeaderRect.isExpanded = !sectionHeaderRect.isExpanded;
                        }
                    }
                }
            }

            Component {
                id: listdelegate

                // property var headerCheckboxGroupId
                Rectangle {
                    id: menuItem
                    width: root.width
                    color: __style.transparentColor
                    visible: aVisible

                    // TODO: turn on?
                    // clip: true
                    onVisibleChanged: {
                        if (visible)
                            height = 45;
                        else
                            height = 0;
                    }

                    Behavior on height {
                        NumberAnimation {
                            // duration: 480 //300
                            properties: "y"
                        }
                    }
                    ColumnLayout {
                        anchors {
                            fill: parent
                        }
                        spacing: 0
                        RowLayout {
                            Layout.preferredHeight: parent.height
                            Layout.preferredWidth: parent.width
                            Layout.fillWidth: true
                            Layout.rightMargin: 23

                            BodyLargeText {
                                id: text
                                text: name
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }
                            CheckBox {
                                id: menuItemCheckBox
                                checked: checked
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                                // ButtonGroup.group: headerCheckboxGroupId
                            }
                        }
                        Rectangle {
                            Layout.preferredHeight: 1
                            Layout.preferredWidth: parent.width
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignBottom
                            color: __style.outlineVariant
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            menuItemCheckBox.checked = !menuItemCheckBox.checked;
                            // listing.currentIndex = index
                        }
                    }
                }
            }
        }
    }
} // RowLayout {//     id: controlButtons//     width: parent.width//     anchors {//         bottom: parent.bottom//         right: parent.right//         left: parent.left//     }//     MaterialButton {//         Layout.alignment: Qt.AlignRight//         contentText: qsTr("Confirm")//         // TODO://         onClicked: root.close()//     }
//     MaterialButton {
//         Layout.alignment: Qt.AlignRight
//         contentText: qsTr("Cancel")
//         onClicked: root.close()
//     }
// }


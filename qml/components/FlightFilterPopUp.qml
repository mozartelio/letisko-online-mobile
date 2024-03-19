import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import "./typography/headline/text"
import "./typography/label/text"

Popup {
    id: root
    Material.theme: Material.Light
    width: 300
    height: 400
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
    anchors.centerIn: Overlay.overlay

    background: Rectangle {
        color: "#ECE6F0"
        radius: 28
    }

    Overlay.modal: Rectangle {
        color: "#aacfdbe7"
    }

    HeadlineSmallText {
        id: filtersHeader
        horizontalAlignment: Text.AlignLeft
        width: parent.width
        text: "Filters"
        padding: 24
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }

    Item {
        id: filtersSections
        width: parent.width
        clip: true
        anchors {
            left: parent.left
            right: parent.right
            top: filtersHeader.bottom
            bottom: controlButtons.top
        }

        ListModel {
            id: filtersModel
            ListElement {
                name: "Confirmed"
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
        }

        ListView {
            id: listing
            width: root.width //181
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
                width: root.width //181
                color: "transparent" //"red"
                height: 40

                property bool isExpanded: false
                property string currentExpandedSection: ListView.view.expandedSection

                onCurrentExpandedSectionChanged: {
                    if (currentExpandedSection === section)
                        isExpanded = true
                    else
                        isExpanded = false
                }

                onIsExpandedChanged: {
                    if (isExpanded) {
                        // color = "blue"
                        ListView.view.expandedSection = section
                    }
                    // else
                    //     color = "transparent"
                    for (var i = 0; i < filtersModel.count; i++) {
                        var animal = filtersModel.get(i)
                        if (section === animal.type)
                            animal.aVisible = sectionHeaderRect.isExpanded
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
                        color: "#CAC4D0"
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        // anchors {
                        //     top: parent.top
                        //     left: parent.left
                        //     right: parent.right
                        // }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillWidth: true

                        // CheckBox {
                        //     id: sectionBox
                        //     checkState: sectionElementsGroup.checkState
                        // }
                        Text {
                            id: sectionHeaderText
                            text: section
                            Layout.alignment: Qt.AlignVCenter | Text.AlignLeft
                        }
                        Image {
                            id: sectionImage
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                            Layout.preferredWidth: 10
                            Layout.preferredHeight: 10
                            source: isExpanded ? "../../assets/icons/arrow_top.svg" : "../../assets/icons/arrow_bottom.svg"
                            // verticalAlignment: Image.AlignVCenter
                            horizontalAlignment: Image.AlignRight
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        sectionHeaderRect.isExpanded = !sectionHeaderRect.isExpanded
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
                color: "transparent"
                // color: ListView.isCurrentItem ? "lightblue" : "white"
                visible: aVisible
                clip: true
                Layout.fillWidth: true
                onVisibleChanged: {
                    if (visible)
                        height = 55
                    else
                        height = 0
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 500
                    }
                }

                RowLayout {
                    anchors {
                        fill: parent
                    }
                    Text {
                        id: text
                        text: name
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        // horizontalAlignment: Text.AlignLeft
                    }
                    CheckBox {
                        id: menuItemCheckBox
                        checked: checked
                        Layout.alignment: Qt.AlignVCenter //| Qt.AlignRight
                        // ButtonGroup.group: headerCheckboxGroupId
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        menuItemCheckBox.checked = !menuItemCheckBox.checked
                        // listing.currentIndex = index
                    }
                }
            }
        }
    }

    RowLayout {
        id: controlButtons
        width: parent.width
        anchors {
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }

        MaterialButton {
            Layout.alignment: Qt.AlignRight
            contentText: "Confirm"
            // TODO:
            onClicked: root.close()
        }

        MaterialButton {
            Layout.alignment: Qt.AlignRight
            contentText: "Cancel"
            onClicked: root.close()
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.letiskoonline.UserController
import "../components"
import "../components/typography/headline/text/"
import "../components/typography/title/text/"

Page {
    signal goToMainScreen

    background: Rectangle {
        color: __style.onPrimaryColor
    }

    contentItem: Item {
        height: parent.height

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            fill: parent
            topMargin: 40
            bottomMargin: 40
            centerIn: parent
        }

        ColumnLayout {
            spacing: 0
            height: parent.height
            width: contentWidth

            anchors {
                centerIn: parent
            }

            HeadlineSmallText {
                id: textLabel
                text: qsTr("Fill in profile information")
                font.bold: true
                color: __style.blackColor
                Layout.preferredWidth: parent.width
                Layout.fillWidth: true
                Layout.preferredHeight: textLabel.implicitHeight
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TextField {
                id: nameFiled
                placeholderText: qsTr("Name")
                Layout.minimumWidth: nameFiled.placeholderText.length * nameFiled.font.pixelSize
                Layout.preferredWidth: streetBuildingBumberRow.width
                Layout.alignment: Qt.AlignLeft
            }
            TextField {
                id: surnameField
                placeholderText: qsTr("Surname")
                Layout.minimumWidth: surnameField.placeholderText.length * surnameField.font.pixelSize
                Layout.preferredWidth: streetBuildingBumberRow.width
                Layout.alignment: Qt.AlignLeft
            }
            RowLayout {
                id: streetBuildingBumberRow
                Layout.alignment: Qt.AlignLeft
                TextField {
                    id: streetField
                    placeholderText: qsTr("Street")
                    Layout.minimumWidth: streetField.placeholderText.length * streetField.font.pixelSize
                    Layout.preferredWidth: 250
                    Layout.alignment: Qt.AlignLeft
                }
                TextField {
                    id: buildingNumberField
                    placeholderText: qsTr("Building number")
                    Layout.minimumWidth: buildingNumberField.placeholderText.length * buildingNumberField.font.pointSize
                    Layout.alignment: Qt.AlignLeft
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignLeft

                TextField {
                    id: zipCodeField
                    placeholderText: qsTr("Zip Code")
                }
                TextField {
                    id: cityField
                    placeholderText: qsTr("City")
                    Layout.preferredWidth: streetBuildingBumberRow.width - zipCodeField.width
                }
            }
            ComboBox {
                id: countryComboBox
                model: ["Slovakia", "Hungary", "Poland", "England"]
                currentIndex: 0 // preselected Slovakia
                Layout.alignment: Qt.AlignLeft
                Layout.preferredWidth: streetBuildingBumberRow.width
            }

            // TextField {
            //     id: dateTimeField
            //     placeholderText: qsTr("Select Date and Time")
            //     readOnly: true

            //     MouseArea {
            //         anchors.fill: parent
            //         onClicked: dateTimeDialog.open()
            //     }

            //     Dialog {
            //         id: dateTimeDialog
            //         title: "Select Date and Time"
            //         modal: true
            //         standardButtons: Dialog.Ok | Dialog.Cancel

            //         Column {
            //             spacing: 10
            //             Row {
            //                 SpinBox {
            //                     id: dayPicker
            //                     from: 1
            //                     to: 31
            //                     // prefix: "Day: "
            //                 }
            //                 Row {
            //                     TextField {
            //                         id: monthField
            //                         placeholderText: qsTr("Month")
            //                         Layout.minimumWidth: monthField.placeholderText.length
            //                                              * monthField.font.pixelSize
            //                         Layout.preferredWidth: streetBuildingBumberRow.width
            //                         Layout.alignment: Qt.AlignLeft
            //                         validator: IntValidator {
            //                             bottom: 1
            //                             top: 12
            //                         }
            //                         onTextChanged: {
            //                             if (parseInt(text) < 1 || parseInt(
            //                                         text) > 12) {
            //                                 text = "1"
            //                             }
            //                         }
            //                     }
            //                     Button {
            //                         text: "+"
            //                         onClicked: {
            //                             if (parseInt(monthField.text) < 12) {
            //                                 monthField.text = (parseInt(
            //                                                        monthField.text) + 1).toString()
            //                             }
            //                         }
            //                     }
            //                     Button {
            //                         text: "-"
            //                         onClicked: {
            //                             if (parseInt(monthField.text) > 1) {
            //                                 monthField.text = (parseInt(
            //                                                        monthField.text) - 1).toString()
            //                             }
            //                         }
            //                     }
            //                 }
            //                 SpinBox {
            //                     id: yearPicker
            //                     from: 1900
            //                     to: new Date().getFullYear()
            //                     // prefix: "Year: "
            //                 }
            //             }
            //             Row {
            //                 SpinBox {
            //                     id: hourPicker
            //                     from: 0
            //                     to: 23
            //                     // prefix: "Hour: "
            //                 }
            //                 SpinBox {
            //                     id: minutePicker
            //                     from: 0
            //                     to: 59
            //                     // prefix: "Minute: "
            //                 }
            //             }
            //             Button {
            //                 text: "OK"
            //                 onClicked: {
            //                     var selectedHour = hourPicker.value
            //                             < 10 ? "0" + hourPicker.value : hourPicker.value
            //                     var selectedMinute = minutePicker.value
            //                             < 10 ? "0" + minutePicker.value : minutePicker.value
            //                     dateTimeField.text = dayPicker.value + "/"
            //                             + monthPicker.value + "/" + yearPicker.value
            //                             + " " + selectedHour + ":" + selectedMinute
            //                     dateTimeDialog.close()
            //                 }
            //             }
            //         }
            //     }
            // }

            // RowLayout {
            //     // centre time label
            //     anchors.centerIn: parent
            //     Text {
            //         id: h
            //         font.pixelSize: 30
            //         font.bold: true
            //         text: outer.currentItem.text
            //     }
            //     Text {
            //         id: div
            //         font.pixelSize: 30
            //         font.bold: true
            //         text: qsTr(":")
            //     }
            //     Text {
            //         id: m
            //         font.pixelSize: 30
            //         font.bold: true
            //         text: inner.currentItem.text
            //     }

            //     MouseArea {
            //         anchors.fill: parent
            //         onClicked: outer.choiceActive = inner.choiceActive = !outer.choiceActive
            //     }
            // }

            // PathView {
            //     // hours path
            //     id: outer
            //     property bool pressed: false
            //     model: 12

            //     interactive: false
            //     highlightRangeMode: PathView.NoHighlightRange
            //     property bool choiceActive: false

            //     highlight: Rectangle {
            //         id: rect
            //         width: 30 * 1.5
            //         height: width
            //         radius: width / 2
            //         border.color: "darkgray"
            //         color: "steelblue"
            //         visible: outer.choiceActive
            //     }

            //     delegate: Item {
            //         id: del
            //         width: 30
            //         height: 30
            //         property bool currentItem: PathView.view.currentIndex == index
            //         property alias text: textHou.text
            //         Text {
            //             id: textHou
            //             anchors.centerIn: parent
            //             font.pixelSize: 24
            //             font.bold: currentItem
            //             text: index + 1
            //             color: currentItem ? "black" : "gray"
            //         }

            //         MouseArea {
            //             anchors.fill: parent
            //             enabled: outer.choiceActive
            //             onClicked: outer.choiceActive = false
            //             hoverEnabled: true
            //             onEntered: outer.currentIndex = index
            //         }
            //     }

            //     path: Path {
            //         startX: 200
            //         startY: 40
            //         PathArc {
            //             x: 80
            //             y: 240
            //             radiusX: 110
            //             radiusY: 110
            //             useLargeArc: false
            //         }
            //         PathArc {
            //             x: 200
            //             y: 40
            //             radiusX: 110
            //             radiusY: 110
            //             useLargeArc: false
            //         }
            //     }
            // }

            // PathView {
            //     // minutes path
            //     id: inner
            //     property bool pressed: false
            //     model: 6
            //     interactive: false
            //     highlightRangeMode: PathView.NoHighlightRange
            //     property bool choiceActive: false

            //     highlight: Rectangle {
            //         width: 30 * 1.5
            //         height: width
            //         radius: width / 2
            //         border.color: "darkgray"
            //         color: "lightgreen"
            //         visible: inner.choiceActive
            //     }

            //     delegate: Item {
            //         width: 30
            //         height: 30
            //         property bool currentItem: PathView.view.currentIndex == index
            //         property alias text: textMin.text
            //         Text {
            //             id: textMin
            //             anchors.centerIn: parent
            //             font.pixelSize: 24
            //             font.bold: currentItem
            //             text: index * 10
            //             color: currentItem ? "black" : "gray"
            //         }

            //         MouseArea {
            //             anchors.fill: parent
            //             enabled: inner.choiceActive
            //             onClicked: inner.choiceActive = false
            //             hoverEnabled: true
            //             onEntered: inner.currentIndex = index
            //         }
            //     }

            //     path: Path {
            //         startX: 140
            //         startY: 60
            //         PathArc {
            //             x: 140
            //             y: 220
            //             radiusX: 40
            //             radiusY: 40
            //             useLargeArc: false
            //         }
            //         PathArc {
            //             x: 140
            //             y: 60
            //             radiusX: 40
            //             radiusY: 40
            //             useLargeArc: false
            //         }
            //     }
            // }

            // // to set current time!
            // onVisibleChanged: {
            //     var d = new Date();
            //     outer.currentIndex = d.getUTCHours() % 12;
            //     inner.currentIndex = d.getMinutes() / 10;
            // }

            // TextField {
            //     id: qualificationStartDatePicker
            //     placeholderText: qsTr("Qualification Start Date")
            //     inputMask: "00/00/0000 00:00"
            //     Layout.alignment: Qt.AlignLeft
            //     Layout.preferredWidth: streetBuildingBumberRow.width

            //     validator: RegularExpressionValidator {
            //         // Regular expression for date in format dd/mm/yyyy and time in 24h format hh:mm
            //         regularExpression: /^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4} ([01]?[0-9]|2[0-3]):[0-5][0-9]$/
            //     }
            // }

            // TextField {
            //     id: qualificationEndDatePicker
            //     placeholderText: qsTr("Qualification End Date")
            //     inputMask: "00/00/0000"
            //     Layout.alignment: Qt.AlignLeft
            //     Layout.preferredWidth: streetBuildingBumberRow.width
            // }

            MaterialButton {
                id: button
                backgroundColor: __style.primaryColor
                contentText: qsTr("Next")
                contentTextColor: __style.onPrimaryColor
                imagePath: __style.rightChevronIconWhite

                enabled: isFormValid()
                onClicked: {
                    //     if (!emailInput.validationRegex.test(emailInput.text)) {
                    //         infoPopupTextContent.text = privates.loginErrorText + "\n" + qsTr(
                    //                     "entered value is not a valid email!")
                    //         infoPopup.open()
                    //         return
                    //     }
                    //     ;
                    loadingPopup.open();
                    UserController.fillInProfileDetails(nameFiled.text, surnameField.text, streetField.text, buildingNumberField.text, zipCodeField.text, cityField.text, countryComboBox.currentText);
                }
                Layout.alignment: Qt.AlignCenter
            }
        }
    }

    PopupBusyIndicator {
        id: loadingPopup
    }

    PopupParent {
        id: infoPopup
        leftButon.visible: false
        rightButton.contentText: qsTr("OK")
        content: TitleMediumText {
            id: infoPopupTextContent
            color: __style.blackColor
            width: parent.width
            height: parent.height
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Connections {
        target: UserController
        function onProfileDetailsFilledInResult(result) {
            if (result === true) {
                goToMainScreen();
            } else {
                infoPopupTextContent.text = privates.loginErrorText + "\n" + result;
                loadingPopup.close();
                infoPopup.open();
            }
        }
    }

    function isFormValid() {
        return (nameFiled.text.trim() !== "" && nameFiled.text !== undefined) && (surnameField.text.trim() !== "" && surnameField.text !== undefined) && (streetField.text.trim() !== "" && streetField.text !== undefined) && (buildingNumberField.text.trim() !== "" && buildingNumberField.text !== undefined) && (zipCodeField.text.trim() !== "" && zipCodeField.text !== undefined) && (cityField.text.trim() !== "" && cityField.text !== undefined);
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.letiskoonline.UserController
import "../components"
import "../components/typography/headline/text/"

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

            MaterialButton {
                id: button
                backgroundColor: __style.primaryColor
                contentText: qsTr("Next step")
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
                    //     UserController.doLogin(emailInput.text, passswordInput.text)
                }
                Layout.alignment: Qt.AlignCenter
            }
        }
    }

    PopupBusyIndicator {
        id: loadingPopup
    }

    function isFormValid() {
        return (nameFiled.text.trim() !== "" && nameFiled.text !== undefined) && (surnameField.text.trim() !== "" && surnameField.text !== undefined) && (streetField.text.trim() !== "" && streetField.text !== undefined) && (buildingNumberField.text.trim() !== "" && buildingNumberField.text !== undefined) && (zipCodeField.text.trim() !== "" && zipCodeField.text !== undefined) && (cityField.text.trim() !== "" && cityField.text !== undefined);
    }
}

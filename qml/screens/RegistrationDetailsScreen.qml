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
                maximumLength: 254
                placeholderText: qsTr("Name")
                Layout.minimumWidth: nameFiled.placeholderText.length * nameFiled.font.pixelSize
                Layout.preferredWidth: streetBuildingBumberRow.width
                Layout.alignment: Qt.AlignLeft
            }
            TextField {
                id: surnameField
                maximumLength: 254
                placeholderText: qsTr("Surname")
                Layout.minimumWidth: surnameField.placeholderText.length
                                     * surnameField.font.pixelSize
                Layout.preferredWidth: streetBuildingBumberRow.width
                Layout.alignment: Qt.AlignLeft
            }
            RowLayout {
                id: streetBuildingBumberRow
                Layout.alignment: Qt.AlignLeft
                TextField {
                    id: streetField
                    maximumLength: 254
                    placeholderText: qsTr("Street")
                    Layout.minimumWidth: streetField.placeholderText.length
                                         * streetField.font.pixelSize
                    Layout.preferredWidth: 250
                    Layout.alignment: Qt.AlignLeft
                }
                TextField {
                    id: buildingNumberField
                    maximumLength: 254
                    placeholderText: qsTr("Building number")
                    Layout.minimumWidth: buildingNumberField.placeholderText.length
                                         * buildingNumberField.font.pointSize
                    Layout.alignment: Qt.AlignLeft
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignLeft

                TextField {
                    id: zipCodeField
                    maximumLength: 254
                    placeholderText: qsTr("Zip Code")
                }
                TextField {
                    id: cityField
                    maximumLength: 254
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
                contentText: qsTr("Next")
                contentTextColor: __style.onPrimaryColor
                imagePath: __style.rightChevronIconWhite

                enabled: isFormValid()
                onClicked: {
                    loadingPopup.open()
                    UserController.fillInProfileDetails(
                                nameFiled.text, surnameField.text,
                                streetField.text, buildingNumberField.text,
                                zipCodeField.text, cityField.text,
                                countryComboBox.currentText)
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
            loadingPopup.close()
            if (result === true) {
                goToMainScreen()
            } else {
                infoPopupTextContent.text = privates.loginErrorText + "\n" + result
                infoPopup.open()
            }
        }
    }

    function isFormValid() {
        return (nameFiled.text.trim() !== "" && nameFiled.text !== undefined)
                && (surnameField.text.trim() !== "" && surnameField.text
                    !== undefined) && (streetField.text.trim() !== ""
                                       && streetField.text !== undefined) && (buildingNumberField.text.trim() !== "" && buildingNumberField.text !== undefined) && (zipCodeField.text.trim() !== "" && zipCodeField.text !== undefined)
                && (cityField.text.trim() !== "" && cityField.text !== undefined)
    }
}

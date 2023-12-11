import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

//TODO: odstranit bug ze hesl osa pise za obrazkom oka
TextField {
    property string passswordValue: ""
    property bool showPassword: false

    width: 200 //- imageWidth
    height: 30
    color: "black"
    maximumLength: 255
    verticalAlignment: TextInput.AlignVCenter
    // onTextChanged: passswordValue = text
    echoMode: showPassword ? TextField.Normal : TextField.Password

    background: Rectangle {
        color: "white"
        radius: 5
    }

    Image {
        source: showPassword ? "../../assets/icons/visibility_on.svg" : "../../assets/icons/visibility_off.svg"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        //        sourceSize: Qt.size(100, 100)
        width: 24
        height: 24

        MouseArea {
            anchors.fill: parent
            onClicked: {
                showPassword = !showPassword
            }
        }
    }
}

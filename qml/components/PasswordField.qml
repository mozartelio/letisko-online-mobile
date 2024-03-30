import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

//TODO: odstranit bug ze hesl osa pise za obrazkom oka
TextField {
    property string passswordValue: ""
    property bool showPassword: false

    width: 200 //- imageWidth
    height: 30
    color: __style.blackColor
    maximumLength: 255
    verticalAlignment: TextInput.AlignVCenter
    // onTextChanged: passswordValue = text
    echoMode: showPassword ? TextField.Normal : TextField.Password

    background: Rectangle {
        color: __style.onPrimaryColor
        radius: 5
    }

    Image {
        source: showPassword ? __style.passwordShownIcon : __style.passwordHiddenIcon
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        //        sourceSize: Qt.size(100, 100)
        width: __style.icon24
        height: __style.icon24

        MouseArea {
            anchors.fill: parent
            onClicked: {
                showPassword = !showPassword
            }
        }
    }
}

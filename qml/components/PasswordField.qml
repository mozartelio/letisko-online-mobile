import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

TextField {
    property bool showPassword: false

    color: __style.blackColor
    maximumLength: __style.maximumEmailInputLength
    verticalAlignment: TextInput.AlignVCenter
    echoMode: showPassword ? TextField.Normal : TextField.Password

    // to do not let text be inputed under the icon image
    rightPadding: icon.width + icon.anchors.rightMargin + icon.anchors.leftMargin

    background: Rectangle {
        color: __style.onPrimaryColor
        radius: 5
    }

    Image {
        id: icon
        width: __style.icon24
        height: __style.icon24
        source: showPassword ? __style.passwordShownIcon : __style.passwordHiddenIcon
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 10
            leftMargin: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                showPassword = !showPassword
            }
        }
    }
}

import QtQuick
import QtQuick.Controls

TextField {
    property bool showPassword: false

    maximumLength: __style.maximumEmailInputLength
    verticalAlignment: TextInput.AlignVCenter
    echoMode: showPassword ? TextField.Normal : TextField.Password
    placeholderText: qsTr("Password")
    rightPadding: icon.width + icon.anchors.rightMargin + icon.anchors.leftMargin

    Image {
        id: icon
        width: __style.icon24
        height: __style.icon24
        source: showPassword ? __style.passwordHiddenIcon : __style.passwordShownIcon
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 15
            leftMargin: 15
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                showPassword = !showPassword
            }
        }
    }
}

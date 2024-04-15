import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import com.letiskoonline.UserController
import "../components"
import "../components/typography/body/text/"
import "../components/typography/title/text/"
import "../components/typography/label/text/"
import "../components/typography/headline/text/"

ColumnLayout {
    id: root

    required property string email
    required property string password

    property var modelData: [{
            isDone: (password.length >= 8 ? true : false),
            item: qsTr("8 characters")
        }, {
            isDone: /[A-Z]/.test(password),
            item: qsTr("1 uppercase letter")
        }, {
            isDone: /\d/.test(password),
            item: qsTr("1 number")
        }, {
            isDone: /[!@#$%^&*(),.?":{}|<>]/.test(password),
            item: qsTr("1 special character")
        }, {
            isDone: password !== email,
            // TODO: AND DO NOT CONTAIN IT
            item: qsTr("password must be different from\n      the email address")
        }]


    TitleSmallText {
        text: qsTr("Minimal requirements to a password:")
    }
    Repeater {
        id: model
        width: root.width
        model: root.modelData
        delegate: BodyMediumText {
            text: (modelData.isDone ? "✅" : "🛑") + " " + modelData.item
            wrapMode: Text.WordWrap
        }
    }

    function areAllConditionsMet() {
        for (var i = 0; i < modelData.length; i++) {
            if (!modelData[i].isDone) {
                return false;
            }
        }
        return true;
    }
}

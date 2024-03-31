import QtQuick
import QtQuick.Controls

TextField {
    color: __style.blackColor
    maximumLength: __style.maximumEmailInputLength
    validator: RegularExpressionValidator {
        regularExpression: /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/
    }

    background: Rectangle {
        color: __style.onPrimaryColor
        radius: 5
    }
}

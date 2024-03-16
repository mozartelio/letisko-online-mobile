// pragma Singleton
import QtQuick

Item {
    QtObject {
        id: themes
        readonly property var light: ["#D0BCFF", "#000000", "#FFFFFF"]
        readonly property var dark: []
    }

    property var currentTheme: themes.light
    property alias themes: themes

    readonly property string inverse_primary: themes[0] //"#D0BCFF"
    readonly property string black: themes[1] //"#000000"
    readonly property string white: themes[2] //"#FFFFFF"
    // readonly property string on_surface_variant: "#49454F"
    // readonly property string surface_bright: "#FEF7FF"
    // readonly property string primary: "#6750A4"
    // readonly property string surface_container_low: "#F7F2FA"
    // readonly property string secondary_container: "#E8DEF8"
    // readonly property string outline_variant: "#CAC4D0"
}
// var customColors= {
// inverse_primary: "#D0BCFF"
// black: "#000000"
// white: "#FFFFFF"
// on_surface_variant: "#49454F"
// surface_bright: "#FEF7FF"
// primary: "#6750A4"
// surface_container_low: "#F7F2FA"
// secondary_container: "#E8DEF8"
// outline_variant: "#CAC4D0"
//     //: "#"
// }


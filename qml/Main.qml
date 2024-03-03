import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import com.user 1.0
import "./screens"
import "./components"
import "./components/typography/headline"

ApplicationWindow {

    Material.theme: Material.Light
    Material.accent: Material.Purple

    // property bool drawerAvailable: false
    id: window

    width: 1194
    height: 834
    visible: true
    title: qsTr("Online letisko")
    color: "white"


    /**
     * from here and until the corresponding ending comment code for hot reload was taken from
     * https://github.com/MarkoStanojevic12/ComponentLibrary/tree/Lesson_01_LiveLoader/component_library/Buttons
    */
    Loader {
        id: mainLoader
        anchors.fill: parent

        source: "./MainWindow.qml"

        function reload() {
            mainLoader.source = ""
            QmlEngine.clearCache()
            mainLoader.source = "./MainWindow.qml"
        }
    }

    Connections {
        target: QmlEngine

        function onReloadUI() {
            console.log("Reloading UI")
            mainLoader.reload()
        }
    }
    /*end of source code for hot reload*/

    // header: ToolBar {
    //     height: 64
    //     RowLayout {
    //         anchors {
    //             fill: parent
    //             right: parent.right
    //             left: parent.left
    //         }
    //         spacing: 0
    //         ToolButton {
    //             id: menuButton
    //             Layout.alignment: Qt.AlignVCenter | Qt.AnchorLeft
    //             // anchors.left: parent.left
    //             // anchors.verticalCenter: parent.verticalCenter
    //             icon.source: "../assets/icons/menu-24px.svg"
    //             // onClicked: drawer.open()
    //         }
    //         HeadlineMedium {
    //             // anchors.centerIn: parent
    //             Layout.alignment: Qt.AlignHCenter //| Qt.AnchorCenter
    //             text: qsTr("App")
    //             color: "white"
    //         }

    //         // ToolBarNameButton {
    //         //     Layout.alignment: Qt.AlignVCenter | Qt.AnchorRight
    //         //     // anchors {
    //         //     // verticalCenter: parent.verticalCenter
    //         //     // right: parent.right
    //         //     // }
    //         // }
    //     }
    // }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.user 1.0
import "./screens"
import "./components"
import "."
import UserAppSettings 1.0

ApplicationWindow {
    id: window
    font.family: "Roboto"

    // property bool drawerAvailable: false
    width: 1366
    height: 634
    visible: true
    title: qsTr("Letisko online")

    // to test on a tablet without hotreload
    // MainWindow {}


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
}

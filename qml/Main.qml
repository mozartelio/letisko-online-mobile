import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./screens"
import "./components"
import "."
import UserAppSettings

ApplicationWindow {
    id: window
    font.family: "Roboto"

    width: 1366
    height: 634
    visible: true
    title: qsTr("Letisko online")

    // to test and deploy on a tablet without hotreload
    MainWindow {}


    /**
     * from here and until the corresponding ending comment code for hot reload was taken from
     * https://github.com/MarkoStanojevic12/ComponentLibrary/tree/Lesson_01_LiveLoader/ComponentCreator
    */
    // Loader {
    //     id: mainLoader
    //     anchors.fill: parent

    //     source: "./MainWindow.qml"

    //     function reload() {
    //         mainLoader.source = ""
    //         QmlEngine.clearCache()
    //         mainLoader.source = "./MainWindow.qml"
    //     }
    // }

    // Connections {
    //     target: QmlEngine

    //     function onReloadUI() {
    //         console.log("Reloading UI...")
    //         mainLoader.reload()
    //     }
    // }
    /*end of source code for hot reload*/
}

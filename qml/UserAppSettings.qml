pragma Singleton

import QtCore

Settings {

    // enum Languages {
    //     English,
    //     Slovak
    // }
    // signal languageChanged(int newLanguage)

    // Define a list that represents enum
    readonly property var languageList: [{
            "name": "English",
            "value"/*qsTr("English")*/
            : "en_US" //UserAppSettings.Languages.English
        }, {
            "name": "Slovak",
            "value"/*qsTr("Slovak")*/
            : "sk_SK" //UserAppSettings.Languages.Slovak
        }]

    // The properties here are given default values to account for the first run of the application.
    // After the application has run once, future values will come from the stored settings.
    property bool showExpandedFlights: false
    property string currentLanguage: "en_US" //UserAppSettings.Languages.Slovak

    // onCurrentLanguageChanged: languageChanged(currentLanguage)
}

pragma Singleton

import QtCore

Settings {
    enum Languages {
        English,
        Slovak
    }

    signal languageChanged(int newLanguage)

    // Define a list that represents enum
    readonly property var languageList: [{
            "name": "English" /*qsTr("English")*/
            ,
            "value": UserAppSettings.Languages.English
        }, {
            "name": "Slovak" /*qsTr("Slovak")*/
            ,
            "value": UserAppSettings.Languages.Slovak
        }]

    // The properties here are given default values to account for the first run of the application.
    // After the application has run once, future values will come from the stored settings.
    property bool showExpandedFligths: false
    property int currentLanguage: UserAppSettings.Languages.Slovak

    onCurrentLanguageChanged: languageChanged(currentLanguage)
}

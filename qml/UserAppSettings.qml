pragma Singleton

import QtCore

Settings {
    // enum Languages {
    //     English,
    //     Slovak
    // }

    // The properties here are given default values to account for the first run of the application.
    // After the application has run once, future values will come from the stored settings.
    property bool showExpandedFligths: true
    // property int currentLanguage: UserAppSettings.Languages.Slovak
}

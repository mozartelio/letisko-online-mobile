pragma Singleton

import QtCore

Settings {
    // The properties here are given default values to account for the first run of the application.
    // After the application has run once, future values will come from the stored settings.
    property bool showExpandedFlights: false

    property bool isFlightsEditingLocked: true
}

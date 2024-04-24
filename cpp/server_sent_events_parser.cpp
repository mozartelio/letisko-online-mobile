#include "server_sent_events_parser.h"
#include <QStringList>
#include <QJsonDocument>

namespace ServerSentEventsParser
{
    QPair<QString, QString> parseSseResponse(const QByteArray &eventData)
    {
        QString eventDataString(eventData);

        // Split the event data into lines
        QStringList lines = eventDataString.split("\n");

        // Initialize event type and data
        QString eventType;
        QString eventJsonData;

        // Parse the event type and data
        for (const QString &line : lines)
        {
            if (line.startsWith("event:"))
            {
                eventType = line.mid(6).trimmed(); // Get the part after "event:"
            }
            else if (line.startsWith("data:"))
            {
                eventJsonData = line.mid(5).trimmed(); // Get the part after "data:"
            }
        }

        // parse the event data as JSON in each case separately?!

        return qMakePair(eventType, eventData);
    }
}

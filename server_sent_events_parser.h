#ifndef SERVERSENTEVENTSPARSER_H
#define SERVERSENTEVENTSPARSER_H

#include <QString>
#include <QPair>

namespace ServerSentEventsParser
{
    QPair<QString, QString> parseSseResponse(const QByteArray &eventData);
}

#endif // SERVERSENTEVENTSPARSER_H

#ifndef REQUEST_CONSTANTS_H
#define REQUEST_CONSTANTS_H
#include <QString>
#include <QByteArray>
#include <QObject>

class RequestConstants : public QObject
{
        Q_OBJECT

public:
        static const QByteArray CONTENT_TYPE;
        static const QByteArray USER_AGENT;

        // milliseconds
        static const unsigned int REQUEST_TIMEOUT_MILLISECONDS;
        static const unsigned int  FLIGHTS_RELOAD_TIMER_MILLISECONDS;

        static const QString SERVER_BASE_URL;
        static const QString LOGIN_ENDPOINT;
        static const QString FLIGHTS_ENDPOINT;

private:
        RequestConstants(){};
};

#endif // REQUEST_CONSTANTS_H

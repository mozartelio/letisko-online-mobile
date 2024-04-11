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

        static const unsigned int REQUEST_TIMEOUT_MILLISECONDS;
        static const unsigned int REQUEST_RETRY_TIMEOUT_MILLISECONDS;
        static const unsigned int SERVER_CONNECTION_CHECK_TIMEOUT_MILLISECONDS;

        static const QString HTTP_PROTOCOL_PREFIX;
        static const QString SERVER_NETWORK_ADDRESS;
        static const unsigned int SERVER_PORT;

        static const QString SERVER_REQUEST_URL_AND_PORT;
        static const QString UPDATE_SUBSCRIPTION_STREAM_ENDPOINT;
        static const QString LOGIN_ENDPOINT;
        static const QString FLIGHTS_ENDPOINT;
        static const QString AIRCRAFTS_ENDPOINT;
        static const QString PROFILE_ENDPOINT;
        static const QString AVATAR_ENDPOINT;

        static const QString UPDATE_FLIGHTS_TYPE;
        static const QString UPDATE_AIRCRAFTS_TYPE;

private:
        RequestConstants(){};
};

#endif // REQUEST_CONSTANTS_H

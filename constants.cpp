#include "constants.h"

const QByteArray RequestConstants::CONTENT_TYPE = "application/json";
const QByteArray RequestConstants::USER_AGENT = "Mozilla/5.0 (Linux; Android 10;) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36";

const unsigned int RequestConstants::REQUEST_TIMEOUT_MILLISECONDS = 30000;      // 30000 milliseconds = 30 seconds
const unsigned int RequestConstants::REQUEST_RETRY_TIMEOUT_MILLISECONDS = 5000; // Retry after 5 seconds
const unsigned int RequestConstants::SERVER_CONNECTION_CHECK_TIMEOUT_MILLISECONDS = 10000;

const QString RequestConstants::HTTP_PROTOCOL_PREFIX= "http://";
const QString RequestConstants::SERVER_NETWORK_ADDRESS = "127.0.0.1"; // 85.237.233.151
const unsigned int RequestConstants::SERVER_PORT = 5001;                     // 51
const QString RequestConstants::SERVER_REQUEST_URL_AND_PORT = HTTP_PROTOCOL_PREFIX + SERVER_NETWORK_ADDRESS + ":" + QString::number(SERVER_PORT) + "/";

const QString RequestConstants::UPDATE_SUBSCRIPTION_STREAM_ENDPOINT = "update_subscription_stream";
const QString RequestConstants::LOGIN_ENDPOINT = "auth/login";
const QString RequestConstants::FLIGHTS_ENDPOINT = "flight/flights";
const QString RequestConstants::AIRCRAFTS_ENDPOINT = "aircraft/list";
const QString RequestConstants::PROFILE_ENDPOINT = "edit/profile";
const QString RequestConstants::AVATAR_ENDPOINT = "edit/avatar";

const QString RequestConstants::UPDATE_FLIGHTS_TYPE = "current_flights_update";
const QString RequestConstants::UPDATE_AIRCRAFTS_TYPE = "aircrafts_update";

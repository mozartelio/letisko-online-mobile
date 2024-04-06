#include "request_constants.h"

const QByteArray RequestConstants::CONTENT_TYPE = "application/json";
const QByteArray RequestConstants::USER_AGENT = "Mozilla/5.0 (Linux; Android 10;) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36";

const unsigned int RequestConstants::REQUEST_TIMEOUT_MILLISECONDS = 30000; // 30000 milliseconds = 30 seconds
const unsigned int RequestConstants::FLIGHTS_RELOAD_TIMER_MILLISECONDS = 10000; // 5000 milliseconds = 5 seconds

const QString RequestConstants::SERVER_BASE_URL = "http://85.237.233.151:51/";
const QString RequestConstants::LOGIN_ENDPOINT = "auth/login";
const QString RequestConstants::FLIGHTS_ENDPOINT = "flight/flights";

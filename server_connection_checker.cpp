#include "server_connection_checker.h"
#include "request_constants.h"

ServerConnectionChecker::ServerConnectionChecker(const QString &hostName, quint16 port, QObject *parent)
    : QObject{parent}, m_hostName{hostName}, m_port{port}
{
    m_socket = new QTcpSocket(this);
    connect(m_socket, &QTcpSocket::connected, this, &ServerConnectionChecker::onConnected);
    connect(m_socket, QOverload<QAbstractSocket::SocketError>::of(&QAbstractSocket::errorOccurred), this, &ServerConnectionChecker::onError);

    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &ServerConnectionChecker::checkConnection);
    m_timer->start(RequestConstants::SERVER_CONNECTION_CHECK_TIMEOUT_MILLISECONDS);
}

void ServerConnectionChecker::checkConnection() {
    m_socket->connectToHost(m_hostName, m_port);
}

void ServerConnectionChecker::onConnected() {
    m_socket->disconnectFromHost();
    emit connectionResult(true);
}

void ServerConnectionChecker::onError(QAbstractSocket::SocketError socketError) {
    Q_UNUSED(socketError)
    m_socket->disconnectFromHost();
    emit connectionResult(false);
}

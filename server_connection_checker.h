#ifndef SERVERCONNECTIONCHECKER_H
#define SERVERCONNECTIONCHECKER_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>
#include <QString>

class ServerConnectionChecker : public QObject
{
    Q_OBJECT
public:
    explicit ServerConnectionChecker(const QString &hostName, quint16 port, QObject *parent = nullptr);

signals:
    void connectionResult(bool isConnected);

public slots:
    void checkConnection();

private slots:
    void onConnected();

    void onError(QAbstractSocket::SocketError socketError);

private:
    QString m_hostName;
    quint16 m_port;
    QTcpSocket *m_socket;
    QTimer *m_timer;
};

#endif // SERVERCONNECTIONCHECKER_H

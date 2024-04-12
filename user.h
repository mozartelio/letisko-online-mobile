#ifndef USER_H
#define USER_H

#include <QObject>
#include <QString>
#include <QPixmap>
#include <QTimer>
#include <QNetworkAccessManager>

#include "personal_info.h"

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(PersonalInfo *personalInfo READ getPersonalInfo WRITE setPersonalInfo NOTIFY personalInfoChanged)
    Q_PROPERTY(Address *address READ getAddress WRITE setAddress NOTIFY addressChanged REQUIRED)
    Q_PROPERTY(QString avatarPixmapProviderId READ getAvatarPixmapProviderId CONSTANT REQUIRED)

public:
    explicit User(QNetworkAccessManager *networkManager, QObject *parent = nullptr);

    ~User();

    void requestPersonalInfoAndAddress();

    void requestAvatar();

    QString getJwtAuthorizationToken() const;
    void setJwtAuthorizationToken(const QString &jwtAuthorizationToken);

    PersonalInfo *getPersonalInfo() const;
    void setPersonalInfo(PersonalInfo *personalInfo);

    Address *getAddress() const;
    void setAddress(Address *address);

    QPixmap getAvatar() const;
    bool setAvatar(const QPixmap avatar);

    QString getAvatarPixmapProviderId() const;

    Q_INVOKABLE bool isAvatarPresent() const;

public slots:
    void handlePersonalInfoNetworkReply(QNetworkReply *reply);
    void handleAvatarNetworkReply(QNetworkReply *reply);

signals:
    void personalInfoChanged(PersonalInfo *newPersonalInfo);
    void addressChanged(Address *newAddress);
    void avatarPixmapProviderIdChanged();

private:
    QString m_jwtAuthorizationToken;
    PersonalInfo *m_personalInfo;
    QNetworkAccessManager *m_networkManager;
    QTimer m_personalInfoRequestTimer;
    QTimer m_avatarRequestTimer;
    Address *m_address;
    QPixmap m_avatar;
    QString m_avatarPixmapProviderId = "avatar";

    void jwtAuthorizationTokenChanged();
};

#endif // USER_H

#ifndef PROFILEINFO_H
#define PROFILEINFO_H

#include <QObject>


class PersonalInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString email READ getEmail WRITE setEmail NOTIFY emailChanged REQUIRED)
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged REQUIRED)
    Q_PROPERTY(QString surname READ getSurname WRITE setSurname NOTIFY surnameChanged REQUIRED)

public:
    explicit PersonalInfo(QObject *parent = nullptr);

    explicit PersonalInfo(const QString &email, const QString &name, const QString &surname, QObject *parent = nullptr);

    ~PersonalInfo();

    QString getEmail() const;
    void setEmail(const QString &email);

    QString getName() const;
    void setName(const QString &name);

    QString getSurname() const;
    void setSurname(const QString &surname);

signals:
    void emailChanged(const QString &newEmail);
    void nameChanged(const QString &newName);
    void surnameChanged(const QString &newSurname);

private:
    QString m_email;
    QString m_name;
    QString m_surname;
};

#endif // PROFILEINFO_H

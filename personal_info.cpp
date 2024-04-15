#include <qDebug>

#include "personal_info.h"

PersonalInfo::PersonalInfo(QObject *parent)
    : QObject{parent}
{
}

PersonalInfo::PersonalInfo(const QString &email, const QString &name, const QString &surname, QObject *parent)
    : QObject{parent},
      m_email{email},
      m_name{name},
      m_surname{surname}
{
}

PersonalInfo::~PersonalInfo() = default;

QString PersonalInfo::getEmail() const
{
    return m_email;
}

void PersonalInfo::setEmail(const QString &email)
{
    if (m_email != email)
    {
        m_email = email;
        emit emailChanged(email);
    }
}

QString PersonalInfo::getName() const
{
    // qDebug() << "ProfileInfo::getName(): " << m_name;
    return m_name;
}

void PersonalInfo::setName(const QString &name)
{
    if (m_name != name)
    {
        m_name = name;
        // qDebug() << "ProfileInfo::NEW Name(): " << m_name;
        emit nameChanged(name);
    }
}

QString PersonalInfo::getSurname() const
{
    // qDebug() << "ProfileInfo::getSurname(): " << m_surname;
    return m_surname;
}

void PersonalInfo::setSurname(const QString &surname)
{
    if (m_surname != surname)
    {
        m_surname = surname;
        // qDebug() << "ProfileInfo::NEW SURName(): " << m_name;
        emit surnameChanged(surname);
    }
}

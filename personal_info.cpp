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
    return m_name;
}

void PersonalInfo::setName(const QString &name)
{
    if (m_name != name)
    {
        m_name = name;
        emit nameChanged(name);
    }
}

QString PersonalInfo::getSurname() const
{
    return m_surname;
}

void PersonalInfo::setSurname(const QString &surname)
{
    if (m_surname != surname)
    {
        m_surname = surname;
        emit surnameChanged(surname);
    }
}

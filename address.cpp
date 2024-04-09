#include "address.h"

Address::Address(QObject *parent)
    : QObject{parent}
{
}

Address::Address(const QString &buildingNumber, const QString &city, const QString &street, const QString &state, const QString &zipCode)
    : m_buildingNumber{buildingNumber},
      m_city{city},
      m_street{street},
      m_state{state},
      m_zipCode{zipCode}
{
}

Address::~Address()
{
}

QString Address::getBuildingNumber() const
{
    return m_buildingNumber;
}

void Address::setBuildingNumber(const QString &buildingNumber)
{
    m_buildingNumber = buildingNumber;
    emit buildingNumberChanged(m_buildingNumber);
}

QString Address::getCity() const
{
    return m_city;
}

void Address::setCity(const QString &city)
{
    m_city = city;
    emit cityChanged(m_city);
}

QString Address::getState() const
{
    return m_state;
}

void Address::setState(const QString &state)
{
    m_state = state;
    emit stateChanged(m_state);
}

QString Address::getStreet() const
{
    return m_street;
}

void Address::setStreet(const QString &street)
{
    m_street = street;
    emit streetChanged(m_street);
}

QString Address::getZipCode() const
{
    return m_zipCode;
}

void Address::setZipCode(const QString &zipCode)
{
    m_zipCode = zipCode;
    emit zipCodeChanged(m_zipCode);
}

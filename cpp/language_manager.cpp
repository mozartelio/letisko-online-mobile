#include "language_manager.h"

LanguageManager::LanguageManager(QGuiApplication *app, QQmlEngine *engine, QObject *parent)
    : QObject{parent}, m_app{app}, m_engine{engine}, m_currentLanguage{English}, m_settings{"OnlineLetisko", "OnlineLetiskoMobileApp"}
{
    connect(this, &LanguageManager::currentLanguageChanged, this, [this]()
            { m_engine->retranslate(); });
    loadUserLanguage();
}

void LanguageManager::loadUserLanguage()
{
    Languages userLanguage = static_cast<Languages>(m_settings.value("userLanguage", English).toInt());
    setCurrentLanguage(userLanguage);
}

void LanguageManager::setCurrentLanguage(Languages language)
{
    if (m_currentLanguage != language)
    {
        if (language == English)
        {
            m_app->removeTranslator(&m_translator);
        }
        // do not use as qrc:/translations/, it will not work
        else if (m_translator.load(":/translations/" + languageCode(language) + ".qm"))
        {
            m_app->installTranslator(&m_translator);
        }
        else
        {
            qCritical() << "Failed to load translation for language: " << language;
            return;
        }
        m_currentLanguage = language;
        m_settings.setValue("userLanguage", language);
        emit currentLanguageChanged();
    }
}

LanguageManager::Languages LanguageManager::getCurrentLanguage() const
{
    return m_currentLanguage;
}

Q_INVOKABLE QString LanguageManager::languageCode(Languages language) const
{
    switch (language)
    {
    case English:
        return "en_US";
    case Slovak:
        return "sk_SK";
    default:
        return "en_US";
    }
}

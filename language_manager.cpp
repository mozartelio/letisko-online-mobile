#include "language_manager.h"

LanguageManager::LanguageManager(QGuiApplication *app, QQmlEngine *engine, QObject *parent)
    : QObject{parent}, m_app{app}, m_engine{engine}, m_currentLanguage{English}, m_settings{"OnlineLetisko", "OnlineLetiskoMobileApp"}
{
    // Load the default .qm file for the current language otherwise a default language will be English

    // qDebug() << "I WILL TRY TO SET TRANSLATION: " + QLocale::system().name()+ ".qm";

    // if (m_translator.load("qrc:/translations/"+ QLocale::system().name()+ ".qm")){
    //     m_app->installTranslator(&m_translator);
    // }
    connect(this, &LanguageManager::currentLanguageChanged, this, [this]() {
        m_engine->retranslate();
    });
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
        else if (m_translator.load(languageCode(language) + ".qm"))
        {
            m_app->installTranslator(&m_translator);
        }
        else
        {
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

QString LanguageManager::languageCode(Languages language) const
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

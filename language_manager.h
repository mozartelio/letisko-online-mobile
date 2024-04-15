#ifndef LANGUAGEMANAGER_H
#define LANGUAGEMANAGER_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QSettings>
#include <QQmlEngine>

class LanguageManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Languages currentLanguage READ getCurrentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
public:
    explicit LanguageManager(QGuiApplication *app, QQmlEngine *engine, QObject *parent = nullptr);

    enum Languages {
        English,
        Slovak
    };
    Q_ENUM(Languages)

    Languages getCurrentLanguage() const;

    QString languageCode(Languages language) const;

    void loadUserLanguage();

public slots:
    void setCurrentLanguage(Languages language);

signals:
    void currentLanguageChanged();

private:
    QGuiApplication *m_app;
    QTranslator m_translator;
    Languages m_currentLanguage;
    QSettings m_settings;
    QQmlEngine *m_engine;
};

#endif // LANGUAGEMANAGER_H

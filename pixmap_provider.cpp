#include <QPixmap>
#include <QString>
#include <QSize>

#include "pixmap_provider.h"

PixmapProvider *PixmapProvider::m_instance = nullptr;

PixmapProvider *PixmapProvider::instance()
{
    if (m_instance == nullptr)
    {
        m_instance = new PixmapProvider();
            qDebug() << "PixmapProvider::instance():";
    }

    return m_instance;
}

PixmapProvider::~PixmapProvider()
{
    delete m_instance;
    m_instance = nullptr;
}

void PixmapProvider::addPixmap(const QString &id, const QPixmap &pixmap)
{
    m_pixmaps[id] = pixmap;
}

void PixmapProvider::removePixmap(const QString &id)
{
    m_pixmaps.remove(id);
}

QString PixmapProvider::getPixmapProviderName() const
{
    return PixmapProvider::m_pixmapProviderName;
}

QPixmap PixmapProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(size)
    Q_UNUSED(requestedSize)
    return m_pixmaps.value(id);
}

#ifndef PIXMAPPROVIDER_H
#define PIXMAPPROVIDER_H

#include <QPixmap>
#include <QString>
#include <QSize>
#include <QMap>
#include <QQuickImageProvider>

class PixmapProvider : public QQuickImageProvider
{
    Q_PROPERTY(QString pixmapProviderName READ getPixmapProviderName CONSTANT)

public:
    static PixmapProvider *instance();

    void addPixmap(const QString &id, const QPixmap &pixmap);

    void removePixmap(const QString &id);

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override;

    Q_INVOKABLE QString getPixmapProviderName() const;

private:
    PixmapProvider()
        : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {
    }
    ~PixmapProvider();

    static PixmapProvider *m_instance;

    PixmapProvider(const PixmapProvider &) = delete;
    void operator=(const PixmapProvider &) = delete;

    QMap<QString, QPixmap> m_pixmaps;
    QString m_pixmapProviderName = "pixmap_images";
};

#endif // PIXMAPPROVIDER_H

/**
 * from here and until the corresponding ending comment code for hot reload was taken from
 * https://github.com/MarkoStanojevic12/ComponentLibrary/tree/Lesson_01_LiveLoader/ComponentCreator
*/
#ifndef FILEWATCHER_H
#define FILEWATCHER_H

#include <QObject>
#include <functional>
#include <QFileSystemWatcher>
#include <QDir>
#include <QTimer>
class FileWatcher : public QObject
{
    Q_OBJECT
public:
    FileWatcher(QObject* parent = Q_NULLPTR);
    void setDirectory(const QString &path);

public Q_SLOTS:
    void onDirectoryChanged(const QString& path);
    void onFileChanged(const QString& path);

private:
    void addPaths(QDir &directory);

private:
    QFileSystemWatcher m_watcher;
    QDir m_dir;
    QTimer m_timer;

Q_SIGNALS:
    void reloadUI();
};

#endif // FILEWATCHER_H
/*end of source code for hot reload*/

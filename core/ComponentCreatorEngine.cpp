/**
 * from here and until the corresponding ending comment code for hot reload was taken from
 * https://github.com/MarkoStanojevic12/ComponentLibrary/tree/Lesson_01_LiveLoader/component_library/Buttons
*/
#include "ComponentCreatorEngine.h"

ComponentCreatorEngine::ComponentCreatorEngine(QObject *parent) :
    QQmlApplicationEngine(parent)
{
#ifdef QT_DEBUG
    m_fileWatcher = new FileWatcher(this);

    QObject::connect(m_fileWatcher, &FileWatcher::reloadUI, this, &ComponentCreatorEngine::reloadUI);
#endif
}

void ComponentCreatorEngine::clearCache()
{
    this->clearComponentCache();
}
/*end of source code for hot reload*/

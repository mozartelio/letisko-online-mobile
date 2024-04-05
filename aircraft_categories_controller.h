#ifndef AIRCRAFT_CATEGORIES_CONTROLLER_H
#define AIRCRAFT_CATEGORIES_CONTROLLER_H

#include <QObject>

class aircraft_categories_controller : public QObject
{
    Q_OBJECT
public:
    explicit aircraft_categories_controller(QObject *parent = nullptr);

signals:
};

#endif // AIRCRAFT_CATEGORIES_CONTROLLER_H

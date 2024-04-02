#ifndef FILTERPROXYMODEL_H
#define FILTERPROXYMODEL_H
#include <QObject>
#include <QSortFilterProxyModel>
#include "filtering_roles.h"

class FlightFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    FlightFilterProxyModel(QObject *parent = 0);

    ~FlightFilterProxyModel();

    Q_INVOKABLE void setFilterString(QString string);

    Q_INVOKABLE void setSortOrder(bool checked);

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;
};
#endif // FILTERPROXYMODEL_H

#ifndef FILTERPROXYMODEL_H
#define FILTERPROXYMODEL_H
#include <QObject>
#include <QSortFilterProxyModel>
#include "filtering_roles.h"

class FlightsFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    FlightsFilterProxyModel(QObject *parent = 0);


    ~FlightsFilterProxyModel();

    Q_INVOKABLE void setFilterString(QString string);

    Q_INVOKABLE void setSortOrder(bool checked);

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

};

#endif // FILTERPROXYMODEL_H

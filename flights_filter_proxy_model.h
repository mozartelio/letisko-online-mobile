#ifndef FILTERPROXYMODEL_H
#define FILTERPROXYMODEL_H
#include <QObject>
#include <QSortFilterProxyModel>

#include "flights_roles.h"

class FlightsFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit FlightsFilterProxyModel(QObject *parent = 0);
    ~FlightsFilterProxyModel();

    Q_INVOKABLE void setFilterString(QString string);

    bool lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const override;

    Q_INVOKABLE void setSortOrder(FlightsRoles::Roles role, bool ascending);

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;
};

#endif // FILTERPROXYMODEL_H

#ifndef AIRCRAFTSFILTERPROXYMODEL_H
#define AIRCRAFTSFILTERPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>


class AircraftsFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit AircraftsFilterProxyModel(QObject *parent = nullptr);
    ~AircraftsFilterProxyModel();

    Q_INVOKABLE void setFilterString(QString string);

    Q_INVOKABLE void setSortOrder(bool checked);

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

};

#endif // AIRCRAFTSFILTERPROXYMODEL_H

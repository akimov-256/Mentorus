#ifndef NAVIGATIONMANAGER_H
#define NAVIGATIONMANAGER_H

#include <QObject>

class NavigationManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)

public:
    explicit NavigationManager(QObject *parent = nullptr);

    void setCurrentPage(int page);
    int currentPage();

private:
    int m_currentPage = 0;

signals:
    void currentPageChanged();
};

#endif // NAVIGATIONMANAGER_H

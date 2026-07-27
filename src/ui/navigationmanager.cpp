#include "navigationmanager.h"

NavigationManager::NavigationManager(QObject *parent)
    : QObject{parent}
{}

int NavigationManager::currentPage() {
    return m_currentPage;
}

void NavigationManager::setCurrentPage(int page) {
    m_currentPage = page;
    emit currentPageChanged();
}
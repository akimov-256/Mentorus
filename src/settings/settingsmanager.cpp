#include "settingsmanager.h"

SettingsManager::SettingsManager(DatabaseManager *dbManager, QObject *parent)
    : QObject{parent}
    , m_dbManager(dbManager)
{}

void SettingsManager::setThemeMode(bool isLight) {
    Setting setting;

    setting.name = "theme";
    setting.value = isLight ? "light" : "dark";

    m_dbManager->InsertSetting(setting);
}

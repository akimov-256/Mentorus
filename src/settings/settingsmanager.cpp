#include "settingsmanager.h"

SettingsManager::SettingsManager(DatabaseManager *dbManager, QObject *parent)
    : QObject{parent}
    , m_dbManager(dbManager)
{
    m_settings = m_dbManager->LoadSettings();
}

void SettingsManager::setThemeMode(bool isLight) {
    Setting setting;

    setting.name = "theme";
    setting.value = isLight ? "light" : "dark";

    m_dbManager->InsertSetting(setting);
}

bool SettingsManager::getThemeMode() {

    if (m_settings["theme"] == "light")
        return true;
    else
        return false;
}

void SettingsManager::setAPIKey(QString apiKey) {
    Setting setting;

    setting.name = "apikey";
    setting.value = apiKey;

    m_dbManager->InsertSetting(setting);
}

QString SettingsManager::getAPIKey() {
    return m_settings["apikey"];
}

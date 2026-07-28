#ifndef SETTINGSMANAGER_H
#define SETTINGSMANAGER_H

#include <QObject>

#include "src/database/databasemanager.h"
#include "src/models/Setting.h"

class SettingsManager : public QObject
{
    Q_OBJECT
public:
    explicit SettingsManager(DatabaseManager *dbManager, QObject *parent = nullptr);

    Q_INVOKABLE void setThemeMode(bool isLight);
    Q_INVOKABLE bool getThemeMode();

    Q_INVOKABLE void setAPIKey(QString apiKey);
    Q_INVOKABLE QString getAPIKey();

    Q_INVOKABLE void setMaxHistory(QString maxHistory);
    Q_INVOKABLE QString getMaxHistory();

private:
    DatabaseManager *m_dbManager;
    QHash<QString, QString> m_settings;

signals:
};

#endif // SETTINGSMANAGER_H

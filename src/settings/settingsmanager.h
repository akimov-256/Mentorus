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

private:
    DatabaseManager *m_dbManager;
    QHash<QString, QString> m_settings;

signals:
};

#endif // SETTINGSMANAGER_H

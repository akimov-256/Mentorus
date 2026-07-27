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

private:
    DatabaseManager *m_dbManager;

signals:
};

#endif // SETTINGSMANAGER_H

#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QCoreApplication>

#include "src/models/Message.h"
#include "src/models/Setting.h"

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

    void InitializeDatabase();
    bool CreateTables();

    bool InsertSetting(const Setting &setting);
    QHash<QString, QString> LoadSettings();

    bool InsertMessage(const Message &message);
    QVector<Message> LoadMessages();

    bool ClearHistory();

signals:
};

#endif // DATABASEMANAGER_H

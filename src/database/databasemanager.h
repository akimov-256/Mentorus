#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QCoreApplication>

#include "src/models/Message.h"

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

    void InitializeDatabase();
    bool CreateTables();

    bool InsertMessage(const Message &message);
    QVector<Message> LoadMessages();
signals:
};

#endif // DATABASEMANAGER_H

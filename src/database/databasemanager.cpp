#include "databasemanager.h"

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject{parent}
{}

void DatabaseManager::InitializeDatabase() {
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    QString dbPath = QCoreApplication::applicationDirPath() + "/mentorus.db";
    db.setDatabaseName(dbPath);

    if (!db.open())
    {
        qDebug() << "failed to open database: " + db.lastError().text();
    }
    else
        qDebug() << "database opened successfully at : " + dbPath;
}
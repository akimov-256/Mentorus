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

    qDebug() << (CreateTables() ? "table creation success" : "table creation failure");
}

bool DatabaseManager::CreateTables() {
    QSqlQuery query;

    QString createStr = "CREATE TABLE IF NOT EXISTS messages ("
                        "id SERIAL PRIMARY KEY,"
                        "fromUser INTEGER NOT NULL,"
                        "date TEXT NOT NULL,"
                        "message TEXT NOT NULL)";

    if (!query.exec(createStr))
        return false;
    return true;
}
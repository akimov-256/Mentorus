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

    QString createMessages = "CREATE TABLE IF NOT EXISTS messages ("
                        "id SERIAL PRIMARY KEY,"
                        "fromUser INTEGER NOT NULL,"
                        "date TEXT NOT NULL,"
                        "message TEXT NOT NULL)";

    if (!query.exec(createMessages))
        return false;

    QString createSettings = "CREATE TABLE IF NOT EXISTS settings ("
                            "name TEXT PRIMARY KEY,"
                             "value TEXT NOT NULL)";

    if (!query.exec(createSettings))
        return false;
    return true;
}

bool DatabaseManager::InsertSetting(const Setting &setting) {
    QSqlQuery query;
    query.prepare("INSERT INTO settings (name, value) VALUES (:name, :value) ON CONFLICT (name) DO UPDATE SET value = excluded.value");

    query.bindValue(":name", setting.name);
    query.bindValue(":value", setting.value);

    if (!query.exec())
        return true;
    return false;
}

QHash<QString, QString> DatabaseManager::LoadSettings() {
    QSqlQuery query;
    query.prepare("SELECT name, value FROM settings");

    if (!query.exec())
        return {};

    QHash<QString, QString> result;

    while (query.next())
    {
        result[query.value(0).toString()] = query.value(1).toString();
    }

    return result;
}

bool DatabaseManager::InsertMessage(const Message &message) {
    QSqlQuery query;
    query.prepare("INSERT INTO messages (fromUser, date, message) VALUES (:fromUser, :date, :message)");

    query.bindValue(":fromUser", (message.fromUser ? 1 : 0));
    query.bindValue(":date", message.date);
    query.bindValue(":message", message.content);

    if (!query.exec())
        return false;
    return true;
}

QVector<Message> DatabaseManager::LoadMessages() {
    QSqlQuery query;
    if (!query.exec("SELECT fromUser, date, message FROM messages ORDER BY id"))
    {
        qDebug() << "failed to load messages from database: " + query.lastError().text();
        return {};
    }

    QVector<Message> messages;

    while (query.next())
    {
        Message msg;
        msg.fromUser = query.value(0).toInt();
        msg.date = query.value(1).toString();
        msg.content = query.value(2).toString();

        messages.append(msg);
    }

    return messages;
}
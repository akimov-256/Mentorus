#include "chatmodel.h"

ChatModel::ChatModel(DatabaseManager *dbManager, QObject *parent)
    : QAbstractListModel(parent)
    , m_dbManager(dbManager)
{
    m_messages = m_dbManager->LoadMessages();
}

void ChatModel::appendUserMessage(const QString &text) {
    beginInsertRows(QModelIndex(), m_messages.size(), m_messages.size());

    Message msg;

    // Populate the message properties
    msg.content = text;
    msg.date = QTime::currentTime().toString("hh:mm AP");
    msg.fromUser = true;

    m_dbManager->InsertMessage(msg);
    m_messages.append(msg);

    endInsertRows();
}

void ChatModel::appendAiMessage(const QString &text) {
    beginInsertRows(QModelIndex(), m_messages.size(), m_messages.size());

    Message msg;
    msg.content = text;
    msg.date = QTime::currentTime().toString("hh:mm AP");
    msg.fromUser = false;

    m_dbManager->InsertMessage(msg);
    m_messages.append(msg);

    endInsertRows();
}

int ChatModel::rowCount(const QModelIndex &) const {
    return m_messages.size();
}

QVariant ChatModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid())
        return {};

    Message msg = m_messages[index.row()];

    switch (role) {
    case TextRole:
        return msg.content;
    case FromUserRole:
        return msg.fromUser;
    case DateRole:
        return msg.date;
    }

    return {};
}

QHash<int, QByteArray> ChatModel::roleNames() const
{
    return
        {
            { TextRole, "text" },
            { DateRole, "date" },
            { FromUserRole, "fromUser" }
        };
}
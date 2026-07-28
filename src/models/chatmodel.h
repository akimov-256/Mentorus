#ifndef CHATMODEL_H
#define CHATMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QTime>

#include "src/models/Message.h"
#include "src/database/databasemanager.h"


class ChatModel : public QAbstractListModel
{
    Q_OBJECT

    enum roles {
        TextRole = Qt::UserRole + 1,
        DateRole,
        FromUserRole
    };

public:
    explicit ChatModel(DatabaseManager *dbManager, QObject *parent = nullptr);

    Q_INVOKABLE void appendUserMessage(const QString &text);
    Q_INVOKABLE void appendAiMessage(const QString &text);
    Q_INVOKABLE void clearHistory();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    QVector<Message> GetMessages();

    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<Message> m_messages;
    DatabaseManager *m_dbManager;

signals:
};

#endif // CHATMODEL_H

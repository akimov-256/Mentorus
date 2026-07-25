#ifndef CHATMODEL_H
#define CHATMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QTime>
#include "src/models/Message.h"



class ChatModel : public QAbstractListModel
{
    Q_OBJECT

    enum roles {
        TextRole = Qt::UserRole + 1,
        DateRole,
        FromUserRole
    };

public:
    explicit ChatModel(QObject *parent = nullptr);

    Q_INVOKABLE void appendUserMessage(const QString &text);
    Q_INVOKABLE void appendAiMessage(const QString &text);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<Message> m_messages;

signals:
};

#endif // CHATMODEL_H

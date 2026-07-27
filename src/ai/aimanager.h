#ifndef AIMANAGER_H
#define AIMANAGER_H

#include <QObject>
#include <QJsonObject>
#include <QJsonArray>

#include "../network/networkmanager.h"
#include "../models/chatmodel.h"
#include "../models/Message.h"

class AiManager : public QObject
{
    Q_OBJECT
public:
    explicit AiManager(NetworkManager *network, ChatModel *chatModel, QObject *parent = nullptr);

    Q_INVOKABLE void sendPrompt();
    QJsonObject BuildJson();

private:
    NetworkManager *m_network;
    ChatModel *m_chatModel;

    void onRequestSucceeded(const QJsonDocument &response);
    void onRequestFailed(const QString &error);

signals:
    void AnswerReady(QString text);
};

#endif // AIMANAGER_H

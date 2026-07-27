#include "aimanager.h"

AiManager::AiManager(NetworkManager *network, ChatModel *chatModel, QObject *parent)
    : QObject{parent}
    , m_network(network)
    , m_chatModel(chatModel)
{
    connect(m_network, &NetworkManager::RequestSucceeded, this, &AiManager::onRequestSucceeded);
    connect(m_network, &NetworkManager::RequestFailed, this, &AiManager::onRequestFailed);
}

void AiManager::sendPrompt() {
    m_network->PostJson(BuildJson());
}

QJsonObject AiManager::BuildJson() {
    QJsonObject body;

    body["model"] = "llama-3.3-70b-versatile";

    QVector<Message> msgList = m_chatModel->GetMessages();

    QJsonArray messages;

    for (Message msg : msgList)
    {
        QJsonObject message;
        message["role"] = msg.fromUser ? "user" : "system";
        message["content"] = msg.content;

        messages.append(message);
    }

    body["messages"] = messages;

    return body;
}

void AiManager::onRequestSucceeded(const QJsonDocument &response)
{
    QJsonObject root = response.object();

    QJsonArray choices = root["choices"].toArray();
    QJsonObject choice = choices[0].toObject();

    QJsonObject message = choice["message"].toObject();
    QString text = message["content"].toString();

    emit AnswerReady(text);
}

void AiManager::onRequestFailed(const QString &error) {
    qDebug() << "request error: " + error;
}
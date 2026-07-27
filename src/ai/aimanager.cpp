#include "aimanager.h"

AiManager::AiManager(NetworkManager *network, QObject *parent)
    : QObject{parent}
    , m_network(network)
{
    connect(m_network, &NetworkManager::RequestSucceeded, this, &AiManager::onRequestSucceeded);
    connect(m_network, &NetworkManager::RequestFailed, this, &AiManager::onRequestFailed);
}

void AiManager::sendPrompt(const QString &prompt) {
    m_network->PostJson(BuildJson(prompt));
}

QJsonObject AiManager::BuildJson(const QString &prompt) {
    QJsonObject body;

    body["model"] = "llama-3.3-70b-versatile";

    QJsonArray messages;

    QJsonObject message;
    message["role"] = "user";
    message["content"] = prompt;

    messages.append(message);

    body["messages"] = messages;

    return body;
}

void AiManager::onRequestSucceeded(const QJsonDocument &response)
{
    qDebug().noquote() << response.toJson(QJsonDocument::Indented);

}

void AiManager::onRequestFailed(const QString &error) {
    qDebug() << "request error: " + error;
}
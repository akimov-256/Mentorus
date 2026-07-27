#include "aimanager.h"

AiManager::AiManager(NetworkManager *network, QObject *parent)
    : QObject{parent}
    , m_network(network)
{
    connect(m_network, &NetworkManager::RequestSucceeded, this, &AiManager::onRequestSucceeded);
    connect(m_network, &NetworkManager::RequestFailed, this, &AiManager::onRequestFailed);
}

void AiManager::sendPrompt(const QString &prompt) {
    QUrl url("https://postman-echo.com/post");

    m_network->PostJson(url, BuildJson(prompt));
}

QJsonObject AiManager::BuildJson(const QString &prompt) {
    QJsonObject body;

    QJsonObject part;
    part["text"] = prompt;

    QJsonArray parts;
    parts.append(part);

    QJsonObject content;
    content["parts"] = parts;

    QJsonArray contents;
    contents.append(content);

    body["contents"] = contents;

    return body;
}

void AiManager::onRequestSucceeded(const QJsonDocument &response)
{
    qDebug().noquote() << response.toJson(QJsonDocument::Indented);

}

void AiManager::onRequestFailed(const QString &error) {
    qDebug() << "request error: " + error;
}
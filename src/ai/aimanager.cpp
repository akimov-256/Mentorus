#include "aimanager.h"

AiManager::AiManager(NetworkManager *network, ChatModel *chatModel, SettingsManager *settingsMan, QObject *parent)
    : QObject{parent}
    , m_network(network)
    , m_chatModel(chatModel)
    , m_settingsMan(settingsMan)
{
    connect(m_network, &NetworkManager::RequestSucceeded, this, &AiManager::onRequestSucceeded);
    connect(m_network, &NetworkManager::RequestFailed, this, &AiManager::onRequestFailed);
}

void AiManager::sendPrompt() {
    m_isGenerating = true;
    emit isGeneratingChanged();

    m_network->PostJson(BuildJson());
}

void AiManager::sendQuizPrompt(QString prompt) {
    m_network->PostJson(BuildQuizJson(prompt));
}

QJsonObject AiManager::BuildJson() {
    QJsonObject body;

    body["model"] = "llama-3.3-70b-versatile";

    QVector<Message> msgList = m_chatModel->GetMessages();

    QJsonArray messages;

    // System message
    QJsonObject systemMessage;
    systemMessage["role"] = "system";
    systemMessage["content"] =
        "You are an educational mentor. "
        "Always respond with ONLY text. "
        "Do not wrap the response in markdown.";

    messages.append(systemMessage);

    const int maxHistory = m_settingsMan->getMaxHistory().toInt();

    int start = qMax(0, msgList.size() - maxHistory);

    for (int i = start; i < msgList.size(); i++)
    {
        QJsonObject message;
        message["role"] = msgList[i].fromUser ? "user" : "system";
        message["content"] = msgList[i].content;

        messages.append(message);
    }

    body["messages"] = messages;

    return body;
}

QJsonObject AiManager::BuildQuizJson(QString prompt)
{
    QJsonObject body;

    body["model"] = "llama-3.3-70b-versatile";

    QJsonArray messages;

    // System message
    QJsonObject systemMessage;
    systemMessage["role"] = "system";
    systemMessage["content"] =
        "You are an educational quiz generator. "
        "Always respond with ONLY valid JSON. "
        "Do not wrap the response in markdown or add explanations.";

    messages.append(systemMessage);

    QJsonObject userMessage;
    userMessage["role"] = "user";
    userMessage["content"] = prompt;

    messages.append(userMessage);

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
    m_isGenerating = false;
    emit isGeneratingChanged();
}

void AiManager::onRequestFailed(const QString &error) {
    qDebug() << "request error: " + error;
    m_isGenerating = false;
    emit isGeneratingChanged();
}

bool AiManager::isGenerating() {
    return m_isGenerating;
}
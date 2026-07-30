#include "aimanager.h"

AiManager::AiManager(NetworkManager *network, ChatModel *chatModel, SettingsManager *settingsMan, QObject *parent)
    : QObject{parent}
    , m_network(network)
    , m_chatModel(chatModel)
    , m_settingsMan(settingsMan)
{
    connect(m_network, &NetworkManager::ChatRequestSucceeded, this, &AiManager::onChatRequestSucceeded);
    connect(m_network, &NetworkManager::ChatRequestFailed, this, &AiManager::onChatRequestFailed);

    connect(m_network, &NetworkManager::QuizRequestSucceeded, this, &AiManager::onQuizRequestSucceeded);
    connect(m_network, &NetworkManager::QuizRequestFailed, this, &AiManager::onQuizRequestFailed);
}

void AiManager::sendChatPrompt() {
    m_isGenerating = true;
    emit isGeneratingChanged();

    m_network->PostJson(BuildJson(), "chat");
}

void AiManager::sendQuizPrompt(QString prompt) {
    m_network->PostJson(BuildQuizJson(prompt), "quiz");
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

void AiManager::onChatRequestSucceeded(const QJsonDocument &response)
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

void AiManager::onQuizRequestSucceeded(const QJsonDocument &response)
{
    QJsonObject root = response.object();

    QJsonArray choices = root["choices"].toArray();
    if (choices.isEmpty())
    {
        return;
    }

    QJsonObject choice = choices.first().toObject();
    QJsonObject message = choice["message"].toObject();

    QString quizJson = message["content"].toString();

    emit QuizReady(quizJson);
}

void AiManager::onChatRequestFailed(const QString &error) {
    qDebug() << "request error: " + error;
    m_isGenerating = false;
    emit isGeneratingChanged();
}

void AiManager::onQuizRequestFailed(const QString &error) {
    qDebug() << "request error: " + error;
}

bool AiManager::isGenerating() {
    return m_isGenerating;
}
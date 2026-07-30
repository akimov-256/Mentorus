#include "networkmanager.h"

NetworkManager::NetworkManager(SettingsManager *settingsMan, QObject *parent)
    : QObject{parent}
    , m_settingsMan(settingsMan)
{}

void NetworkManager::PostJson(const QJsonObject &json, const QString sender) {
    QUrl url("https://api.groq.com/openai/v1/chat/completions");

    QNetworkRequest request(url);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", "Bearer " + m_settingsMan->getAPIKey().toUtf8());

    QByteArray data = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_manager.post(request, data);

    connect(reply, &QNetworkReply::finished, this, [reply, this, sender]() {
        if (reply->error() == QNetworkReply::NoError)
        {
            QByteArray data = reply->readAll();

            QJsonParseError error;
            QJsonDocument response = QJsonDocument::fromJson(data, &error);

            if (error.error == QJsonParseError::NoError)
                if (sender == "chat")
                {
                    emit ChatRequestSucceeded(response);
                }
                else if (sender == "quiz")
                {
                    emit QuizRequestSucceeded(response);
                }
            else
            {
                if (sender == "chat")
                {
                    emit ChatRequestFailed("Failed to parse json response");
                }
                else if (sender == "quiz")
                {
                    emit QuizRequestFailed("Failed to parse json Quiz");
                }
            }
        }
        else
        {
            qDebug() << "HTTP:"
                     << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

            qDebug() << reply->errorString();

            qDebug().noquote() << reply->readAll();

            if (sender == "chat")
            {
                emit ChatRequestFailed(reply->errorString());
            }
            else if (sender == "quiz")
            {
                emit QuizRequestFailed(reply->errorString());
            }
        }

        reply->deleteLater();
    });
}
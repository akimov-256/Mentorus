#include "networkmanager.h"

NetworkManager::NetworkManager(QObject *parent)
    : QObject{parent}
{}

void NetworkManager::PostJson(const QJsonObject &json) {
    QUrl url("https://api.groq.com/openai/v1/chat/completions");

    QNetworkRequest request(url);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", "Bearer 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");

    QByteArray data = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_manager.post(request, data);

    connect(reply, &QNetworkReply::finished, this, [reply, this]() {
        if (reply->error() == QNetworkReply::NoError)
        {
            QByteArray data = reply->readAll();

            QJsonParseError error;
            QJsonDocument response = QJsonDocument::fromJson(data, &error);

            if (error.error == QJsonParseError::NoError)
                emit RequestSucceeded(response);
            else
                emit RequestFailed("Failed to parse json response");
        }
        else
        {
            qDebug() << "HTTP:"
                     << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

            qDebug() << reply->errorString();

            qDebug().noquote() << reply->readAll();

            emit RequestFailed(reply->errorString());
        }

        reply->deleteLater();
    });
}
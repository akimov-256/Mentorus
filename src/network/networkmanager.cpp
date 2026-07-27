#include "networkmanager.h"

NetworkManager::NetworkManager(QObject *parent)
    : QObject{parent}
{}

void NetworkManager::PostJson(const QUrl &url, const QJsonObject &json) {
    QNetworkRequest request(url);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

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
            emit RequestFailed(reply->errorString());

        reply->deleteLater();
    });
}
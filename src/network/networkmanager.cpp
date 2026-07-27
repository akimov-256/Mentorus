#include "networkmanager.h"

NetworkManager::NetworkManager(QObject *parent)
    : QObject{parent}
{}

void NetworkManager::PostJson(const QUrl &url, const QJsonObject &json) {
    QNetworkRequest request(url);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QByteArray data = QJsonDocument(json).toJson();

    QNetworkReply *reply = m_manager.post(request, data);

    connect(reply, &QNetworkReply::finished, this, [reply]() {
        qDebug() << reply->readAll();

        reply->deleteLater();
    });
}
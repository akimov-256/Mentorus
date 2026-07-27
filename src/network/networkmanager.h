#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>

class NetworkManager : public QObject
{
    Q_OBJECT
public:
    explicit NetworkManager(QObject *parent = nullptr);

    void PostJson(const QUrl &url, const QJsonObject &json);

private:
    QNetworkAccessManager m_manager;

signals:
};

#endif // NETWORKMANAGER_H

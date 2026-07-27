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

    void PostJson(const QJsonObject &json);

private:
    QNetworkAccessManager m_manager;

signals:
    void RequestSucceeded(const QJsonDocument &response);
    void RequestFailed(const QString &error);
};

#endif // NETWORKMANAGER_H

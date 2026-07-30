#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>

#include "../settings/settingsmanager.h"

class NetworkManager : public QObject
{
    Q_OBJECT
public:
    explicit NetworkManager(SettingsManager *settingsMan, QObject *parent = nullptr);

    void PostJson(const QJsonObject &json, const QString sender);

private:
    QNetworkAccessManager m_manager;
    SettingsManager *m_settingsMan;

signals:
    void ChatRequestSucceeded(const QJsonDocument &response);
    void QuizRequestSucceeded(const QJsonDocument &response);
    void ChatRequestFailed(const QString &error);
    void QuizRequestFailed(const QString &error);
};

#endif // NETWORKMANAGER_H

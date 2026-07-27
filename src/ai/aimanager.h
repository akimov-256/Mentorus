#ifndef AIMANAGER_H
#define AIMANAGER_H

#include <QObject>
#include <QJsonObject>
#include <QJsonArray>

#include "../network/networkmanager.h"

class AiManager : public QObject
{
    Q_OBJECT
public:
    explicit AiManager(NetworkManager *network, QObject *parent = nullptr);

    Q_INVOKABLE void sendPrompt(const QString &prompt);

private:
    NetworkManager *m_network;

    void onRequestSucceeded(const QJsonDocument &response);
    void onRequestFailed(const QString &error);

signals:
};

#endif // AIMANAGER_H

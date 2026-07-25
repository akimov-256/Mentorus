#ifndef AIMANAGER_H
#define AIMANAGER_H

#include <QObject>

class AiManager : public QObject
{
    Q_OBJECT
public:
    explicit AiManager(QObject *parent = nullptr);

signals:
};

#endif // AIMANAGER_H

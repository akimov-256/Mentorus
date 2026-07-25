#ifndef CHATMODEL_H
#define CHATMODEL_H

#include <QObject>

class ChatModel : public QObject
{
    Q_OBJECT
public:
    explicit ChatModel(QObject *parent = nullptr);

signals:
};

#endif // CHATMODEL_H

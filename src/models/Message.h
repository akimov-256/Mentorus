#ifndef MESSAGE_H
#define MESSAGE_H

#include <qobject.h>

struct Message
{
    QString content;
    QString date;
    bool fromUser;
};

#endif // MESSAGE_H

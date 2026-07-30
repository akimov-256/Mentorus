#ifndef QUIZQUESTION_H
#define QUIZQUESTION_H

#include <QObject>

struct QuizQuestion
{
    QString question;
    QVector<QString> choicesList;
    int selectedIndex;
    int correctIndex;
};

#endif // QUIZQUESTION_H

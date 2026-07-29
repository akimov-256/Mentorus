#ifndef QUIZMANAGER_H
#define QUIZMANAGER_H

#include <QObject>

#include "aimanager.h"

class QuizManager : public QObject
{
    Q_OBJECT
public:
    explicit QuizManager(AiManager *aiManager, QObject *parent = nullptr);

    Q_INVOKABLE void generateQuiz(QString topic, QString difficulty, int count);

    QString buildPrompt(QString topic, QString difficulty, int count);

private:
    AiManager *m_aiManager;

signals:
};

#endif // QUIZMANAGER_H

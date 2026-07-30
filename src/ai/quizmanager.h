#ifndef QUIZMANAGER_H
#define QUIZMANAGER_H

#include <QObject>

#include "aimanager.h"
#include "../models/quizmodel.h"

class QuizManager : public QObject
{
    Q_OBJECT
public:
    explicit QuizManager(AiManager *aiManager, QuizModel *quizModel, QObject *parent = nullptr);

    Q_INVOKABLE void generateQuiz(QString topic, QString difficulty, int count);
    Q_INVOKABLE void finishQuiz();

private:
    AiManager *m_aiManager;
    QuizModel *m_quizModel;

    QString buildPrompt(QString topic, QString difficulty, int count);
    bool ParseQuiz(const QString &json);
    int calculateScore() const;

private slots:
    void onQuizReady(const QString &response);

signals:
    void quizGenerated();
    void quizGenerationFailed(const QString &error);
    void quizFinished(int score, int total);
};

#endif // QUIZMANAGER_H

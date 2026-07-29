#include "quizmanager.h"

QuizManager::QuizManager(AiManager *aiManager, QObject *parent)
    : QObject{parent}
    , m_aiManager(aiManager)
{}

void QuizManager::generateQuiz(QString topic, QString difficulty, int count) {
    QString prompt = buildPrompt(topic, difficulty, count);

    m_aiManager->sendQuizPrompt(prompt);
}

QString QuizManager::buildPrompt(QString topic, QString difficulty, int count) {
    return QString(R"(

Generate %1 multiple-choice questions about "%2".

Difficulty: %3

Return ONLY valid JSON.

Format:

{
    "questions":[
        {
            "question":"",
            "options":["","","",""],
            "answer":0
        }
    ]
})").arg(count).arg(topic).arg(difficulty);
}
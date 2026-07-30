#include "quizmanager.h"

QuizManager::QuizManager(AiManager *aiManager, DatabaseManager *dbManager, QuizModel *quizModel, QObject *parent)
    : QObject{parent}
    , m_aiManager(aiManager)
    , m_dbManager(dbManager)
    , m_quizModel(quizModel)
{
    connect(aiManager, &AiManager::QuizReady, this, &QuizManager::onQuizReady);
}

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

bool QuizManager::ParseQuiz(const QString &json)
{
    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(json.toUtf8(), &error);

    if (error.error != QJsonParseError::NoError || !doc.isObject())
        return false;

    QJsonObject root = doc.object();

    if (!root.contains("questions") || !root["questions"].isArray())
        return false;

    QJsonArray questionsArray = root["questions"].toArray();

    QVector<QuizQuestion> questions;

    for (const QJsonValue &value : questionsArray)
    {
        if (!value.isObject())
            continue;

        QJsonObject obj = value.toObject();

        QuizQuestion question;

        question.question = obj["question"].toString();

        QJsonArray optionsArray = obj["options"].toArray();
        for (const QJsonValue &option : optionsArray)
            question.choicesList.append(option.toString());

        question.correctIndex = obj["answer"].toInt();
        question.selectedIndex = -1;

        questions.append(question);
    }

    if (questions.isEmpty())
        return false;

    m_quizModel->setQuestions(questions);

    return true;
}

int QuizManager::calculateScore() const
{
    int score = 0;

    const QVector<QuizQuestion> &questions = m_quizModel->questions();

    for (const QuizQuestion &question : questions)
    {
        if (question.selectedIndex == question.correctIndex)
            score++;
    }

    m_dbManager->InsertLastQuizScore(score, m_quizModel->rowCount());

    return score;
}

void QuizManager::onQuizReady(const QString &response)
{
    if (ParseQuiz(response))
        emit quizGenerated();
    else
        emit quizGenerationFailed("Failed to parse quiz.");
}

void QuizManager::finishQuiz()
{
    emit quizFinished(calculateScore(),
                      m_quizModel->rowCount());
}
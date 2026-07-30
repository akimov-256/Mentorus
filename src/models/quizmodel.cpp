#include "quizmodel.h"

QuizModel::QuizModel(DatabaseManager *dbManager, QObject *parent)
    : QAbstractListModel(parent)
    , m_dbManager(dbManager)
{}

void QuizModel::setQuestions(QVector<QuizQuestion> questions) {
    beginResetModel();

    m_questions = questions;

    endResetModel();
}

void QuizModel::selectAnswer(int question, int answer)
{
    if (question < 0 || question >= m_questions.size())
        return;

    m_questions[question].selectedIndex = answer;

    QModelIndex idx = index(question);

    emit dataChanged(idx, idx, { SelectedAnswerRole });
    emit selectedAnswerChanged();
}

const QVector<QuizQuestion>& QuizModel::questions() const {
    return m_questions;
}

int QuizModel::questionCount() const {
    return m_questions.size();
}

QString QuizModel::question(int index) const {
    return m_questions[index].question;
}

QStringList QuizModel::options(int index) const {
    return m_questions[index].choicesList;
}

int QuizModel::selectedAnswer(int index) const {
    return m_questions[index].selectedIndex;
}

void QuizModel::clear()
{
    beginResetModel();

    m_questions.clear();

    endResetModel();
}

int QuizModel::rowCount(const QModelIndex &) const {
    return m_questions.size();
}

QVariant QuizModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid())
        return {};

    QuizQuestion quiz = m_questions[index.row()];

    switch (role) {
    case QuestionRole:
        return quiz.question;
    case OptionsRole:
        return quiz.choicesList;
    case SelectedAnswerRole:
        return quiz.selectedIndex;
    }

    return {};
}

QHash<int, QByteArray> QuizModel::roleNames() const {
    return
        {
            { QuestionRole, "question" },
            { OptionsRole, "options" },
            { SelectedAnswerRole, "selected" }
        };
}
#include "quizmodel.h"

QuizModel::QuizModel(DatabaseManager *dbManager, QObject *parent)
    : QAbstractListModel(parent)
    , m_dbManager(dbManager)
{}

void QuizModel::generateQuiz(QString topic, QString difficulty, int quizCount) {

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
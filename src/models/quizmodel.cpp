#include "quizmodel.h"

QuizModel::QuizModel(DatabaseManager *dbManager, QObject *parent)
    : QAbstractListModel(parent)
    , m_dbManager(dbManager)
{}

void QuizModel::generateQuiz(QString topic, QString difficulty, int quizCount) {

}
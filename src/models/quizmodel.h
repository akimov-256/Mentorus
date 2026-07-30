#ifndef QUIZMODEL_H
#define QUIZMODEL_H

#include <QObject>
#include <QAbstractListModel>

#include "QuizQuestion.h"
#include "../database/databasemanager.h"

class QuizModel : public QAbstractListModel
{

    Q_OBJECT
public:

    enum Roles
    {
        QuestionRole = Qt::UserRole + 1,
        OptionsRole,
        SelectedAnswerRole
    };

    explicit QuizModel(DatabaseManager *dbManager, QObject *parent = nullptr);

    void generateQuiz(QString topic, QString difficulty, int quizCount);

private:
    QVector<QuizQuestion> questions;
    DatabaseManager *m_dbManager;

signals:
};

#endif // QUIZMODEL_H

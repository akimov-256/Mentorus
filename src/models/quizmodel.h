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

    Q_INVOKABLE void generateQuiz(QString topic, QString difficulty, int quizCount);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<QuizQuestion> m_questions;
    DatabaseManager *m_dbManager;

signals:
};

#endif // QUIZMODEL_H

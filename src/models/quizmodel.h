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

    void setQuestions(QVector<QuizQuestion> questions);
    Q_INVOKABLE void selectAnswer(int question, int answer);
    const QVector<QuizQuestion>& questions() const;

    // Helper functions
    Q_INVOKABLE int questionCount() const;
    Q_INVOKABLE QString question(int index) const;
    Q_INVOKABLE QStringList options(int index) const;
    Q_INVOKABLE int selectedAnswer(int index) const;

    void clear();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<QuizQuestion> m_questions;
    DatabaseManager *m_dbManager;

signals:
    void selectedAnswerChanged();
};

#endif // QUIZMODEL_H

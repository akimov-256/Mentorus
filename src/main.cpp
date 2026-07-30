#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QJsonObject>
#include <QIcon>

#include "models/chatmodel.h"
#include "models/quizmodel.h"
#include "database/databasemanager.h"
#include "network/networkmanager.h"
#include "ai/aimanager.h"
#include "ai/quizmanager.h"
#include "ui/navigationmanager.h"
#include "settings/settingsmanager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/qt/qml/Mentorus/assets/icons/mentorus.png"));

    NavigationManager naviManager;

    DatabaseManager *dbManager;
    dbManager->InitializeDatabase();

    SettingsManager settingsManager(dbManager);

    NetworkManager nManager(&settingsManager);

    ChatModel chatModel(dbManager);

    AiManager aiManager(&nManager, &chatModel, &settingsManager);

    QObject::connect(&aiManager, &AiManager::AnswerReady, &chatModel, &ChatModel::appendAiMessage);

    QuizModel quizModel(dbManager);

    QuizManager quizManager(&aiManager, dbManager, &quizModel);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("navigation", &naviManager);
    engine.rootContext()->setContextProperty("chatModel", &chatModel);
    engine.rootContext()->setContextProperty("quizModel", &quizModel);
    engine.rootContext()->setContextProperty("quizManager", &quizManager);
    engine.rootContext()->setContextProperty("aiManager", &aiManager);
    engine.rootContext()->setContextProperty("settingsManager", &settingsManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Mentorus", "Main");

    return QGuiApplication::exec();
}

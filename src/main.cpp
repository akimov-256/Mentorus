#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "models/chatmodel.h"
#include "database/databasemanager.h"
#include "network/networkmanager.h"
#include "ai/aimanager.h"
#include "ui/navigationmanager.h"
#include "settings/settingsmanager.h"

#include <QJsonObject>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    NavigationManager naviManager;

    DatabaseManager *dbManager;
    dbManager->InitializeDatabase();

    SettingsManager settingsManager(dbManager);

    NetworkManager nManager(&settingsManager);

    ChatModel chatModel(dbManager);

    AiManager aiManager(&nManager, &chatModel);

    QObject::connect(&aiManager, &AiManager::AnswerReady, &chatModel, &ChatModel::appendAiMessage);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("navigation", &naviManager);
    engine.rootContext()->setContextProperty("chatModel", &chatModel);
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

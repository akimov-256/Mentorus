#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "models/chatmodel.h"
#include "database/databasemanager.h"
#include "network/networkmanager.h"
#include "ai/aimanager.h"

#include <QJsonObject>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    DatabaseManager *dbManager;
    dbManager->InitializeDatabase();

    NetworkManager nManager;

    AiManager aiManager(&nManager);

    ChatModel chatModel(dbManager);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("chatModel", &chatModel);
    engine.rootContext()->setContextProperty("aiManager", &aiManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Mentorus", "Main");

    return QGuiApplication::exec();
}

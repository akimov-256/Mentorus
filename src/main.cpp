#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "models/chatmodel.h"
#include "database/databasemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ChatModel chatModel;
    DatabaseManager dbManager;

    dbManager.InitializeDatabase();


    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("chatModel", &chatModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Mentorus", "Main");

    return QGuiApplication::exec();
}

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "models/chatmodel.h"
#include "database/databasemanager.h"
#include "network/networkmanager.h"

#include <QJsonObject>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    DatabaseManager *dbManager;
    dbManager->InitializeDatabase();

    // network manager test
    QUrl url("https://httpbin.org/post");
    QJsonObject body;
    body["name"] = "mentorus";

    NetworkManager nManager;
    nManager.PostJson(url, body);

    ChatModel chatModel(dbManager);

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

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "models/chatmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ChatModel chatModel;

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

import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import "../components"
import "../theme"


Item {
    id: root

    Layout.fillHeight: true
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark

        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        ColumnLayout {
            anchors.fill: parent

            ListView {
                id: chatView

                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true
                spacing: 10

                model: 10

                delegate: MessageBubble {
                    fromUser: index % 2 === 0
                    messageText: "Hello world " + index
                    messageDate: "11:45 PM"
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded

                    width: 15

                    contentItem: Rectangle {
                        radius: width / 2
                        color: ColorPalette.isLight ? ColorPalette.accentGreenHover : ColorPalette.accentGreenText
                    }

                    background: Rectangle {
                        color: "transparent"
                    }
                }
            }

            LineEdit {
                id: search

                Layout.fillWidth: true
                Layout.margins: 15
                boxHeignt: 45


                placeHolderText: "Ask anything..."
            }
        }
    }
}

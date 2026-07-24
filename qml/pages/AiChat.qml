import QtQuick 2.15
import QtQuick.Layouts
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

            Item {
                Layout.fillHeight: true
            }

            MessageBubble {
                id: message1

                fromUser: false
                messageDate: "9:18 AM"
                messageText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut purus erat, efficitur eu cursus vitae, mattis bibendum dui. Fusce efficitur magna gravida, scelerisque nisi sit amet, fringilla leo. Pellentesque malesuada congue eros et gravida. In sagittis non enim at interdum."
            }

            MessageBubble {
                id: message2

                fromUser: true
                messageDate: "9:18 AM"
                messageText: "hello"
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

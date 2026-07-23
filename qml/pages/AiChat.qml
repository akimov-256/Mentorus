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

                Layout.preferredHeight: 70
                Layout.preferredWidth: 600
                Layout.alignment: Qt.AlignLeft
                Layout.margins: 15

                fromUser: false
            }

            MessageBubble {
                id: message2

                Layout.preferredHeight: 100
                Layout.preferredWidth: 600
                Layout.alignment: Qt.AlignRight
                Layout.margins: 15

                fromUser: true
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

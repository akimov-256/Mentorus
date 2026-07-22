import QtQuick 2.15
import QtQuick.Layouts
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

            // Add welcome text
            Text {
                Layout.topMargin: 40
                Layout.leftMargin: 30

                text: "Welcome back,"

                font.family: appFont.name
                font.pixelSize: 32
                color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
            }

            Text {
                Layout.leftMargin: 30

                text: "Pick up where you left off, or start something new."

                font.family: appFont.name
                font.pixelSize: 22
                color: ColorPalette.midGray
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

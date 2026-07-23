import QtQuick 2.15
import QtQuick.Layouts
import "../theme"


Item {
    id: root

    property string cardTitle
    property string firstLine
    property string secondLine

    Layout.preferredHeight: 100
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.reallyDark
        border.color: ColorPalette.dark
        border.width: 1
        radius: 5

        // Added animation to colors
        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        ColumnLayout {
            anchors.fill: parent

            spacing: 0

            // Create card title text
            Text {
                Layout.topMargin: 10
                Layout.leftMargin: 15
                Layout.alignment: Qt.AlignLeft

                text: cardTitle

                font.family: appFont.name
                font.pixelSize: 22
                color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.surface
            }

            // Create card content
            Text {
                Layout.topMargin: 10
                Layout.leftMargin: 15
                Layout.alignment: Qt.AlignLeft

                text: firstLine

                font.family: appFont.name
                font.pixelSize: 15
                color: ColorPalette.midGray
            }

            Text {
                Layout.topMargin: 5
                Layout.leftMargin: 15
                Layout.alignment: Qt.AlignLeft

                text: secondLine

                font.family: appFont.name
                font.pixelSize: 15
                color: ColorPalette.midGray
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

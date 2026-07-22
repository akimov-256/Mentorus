import QtQuick 2.15
import QtQuick.Layouts
import "../theme"


Item {
    id: root

    property string cardText
    property string iconPath

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

        ColumnLayout {
            anchors.fill: parent

            Item {
                Layout.fillHeight: true
            }

            // Create card icon
            Image {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32

                source: iconPath
            }

            // Create card text
            Text {
                Layout.alignment: Qt.AlignHCenter

                text: cardText

                font.family: appFont.name
                font.pixelSize: 16
                color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.surface
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

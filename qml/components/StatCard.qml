import QtQuick 2.15
import QtQuick.Layouts
import "../theme"

Item {
    id: root

    property string cardTitle
    property string cardValue

    Layout.preferredHeight: 100
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.accentGreenTint : ColorPalette.accentGreenPressed
        radius: 5

        ColumnLayout {
            anchors.fill: parent

            // Create card icon
            Text {
                Layout.topMargin: 15
                Layout.leftMargin: 15
                Layout.alignment: Qt.AlignLeft

                text: cardTitle

                font.family: appFont.name
                font.pixelSize: 20
                color: ColorPalette.isLight ? ColorPalette.accentGreenPressed : ColorPalette.accentGreenTint
            }

            // Create card text
            Text {
                Layout.bottomMargin: 15
                Layout.leftMargin: 15
                Layout.alignment: Qt.AlignLeft

                text: cardValue

                font.family: appFont.name
                font.pixelSize: 28
                color: ColorPalette.isLight ? ColorPalette.accentGreenText : ColorPalette.accentGreenTint
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

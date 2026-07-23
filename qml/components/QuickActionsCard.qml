import QtQuick 2.15
import QtQuick.Layouts
import "../theme"


Item {
    id: root

    property string cardText
    property string iconPath

    signal clicked()

    Layout.preferredHeight: 100
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? mouseArea.containsMouse ? mouseArea.pressed ? Qt.darker(ColorPalette.surface, 1.2) : Qt.darker(ColorPalette.surface, 1.1) : ColorPalette.surface : mouseArea.containsMouse ? mouseArea.pressed ? Qt.lighter(ColorPalette.reallyDark, 1.2) : Qt.lighter(ColorPalette.deepDark, 1.4) : ColorPalette.reallyDark
        border.color: ColorPalette.dark
        border.width: 1
        radius: 5

        // Added animation to colors
        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        // Detect user actions
        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                root.clicked()
            }
        }

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

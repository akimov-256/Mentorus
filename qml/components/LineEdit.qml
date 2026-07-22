import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import "../theme"


Item {
    id: root

    property string placeHolderText
    property string iconPath

    Layout.preferredHeight: 35
    Layout.preferredWidth: 350

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    // Create the background
    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.light : ColorPalette.deepDark

        RowLayout {
            anchors.fill: parent

            spacing: 0

            Image {
                id: icon

                Layout.leftMargin: 5
                Layout.alignment: Qt.AlignVCenter

                Layout.preferredHeight: 20
                Layout.preferredWidth: 20

                source: iconPath
            }

            // Add the text field
            TextField {
                Layout.fillWidth: true

                font.family: appFont.name
                font.pixelSize: 16

                placeholderTextColor: ColorPalette.midGray
                color: ColorPalette.dark

                placeholderText: placeHolderText

                background: Rectangle {
                    color: "transparent"
                }

            }
        }
    }
}

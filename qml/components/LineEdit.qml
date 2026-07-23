import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import "../theme"


Item {
    id: root

    property int boxHeignt
    property int boxWidth
    property string placeHolderText
    property string iconPath
    property bool hasButton: true

    Layout.preferredHeight: boxHeignt
    Layout.preferredWidth: boxWidth

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    // Create the background
    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.light : ColorPalette.deepDark
        border.color: ColorPalette.midGray
        border.width: 1

        radius: 5

        RowLayout {
            anchors.fill: parent

            spacing: 0

            Image {
                id: icon

                Layout.leftMargin: 10
                Layout.alignment: Qt.AlignVCenter

                Layout.preferredHeight: 20
                Layout.preferredWidth: 20

                source: iconPath

                visible: iconPath !== ""
            }

            // Add the text field
            TextField {
                Layout.fillWidth: true

                font.family: appFont.name
                font.pixelSize: 16

                placeholderTextColor: ColorPalette.midGray
                color: ColorPalette.isLight ? ColorPalette.dark : ColorPalette.surface

                placeholderText: placeHolderText

                background: Rectangle {
                    color: "transparent"
                }
            }

            UiButton {
                id: sendButton

                Layout.alignment: Qt.AlignLeft
                Layout.margins: 5

                buttonHeight: root.height - 10
                buttonWidth: buttonHeight

                buttonFillColor: ColorPalette.accentGreen
                buttonHoverColor: ColorPalette.accentGreenHover
                buttonPressColor: ColorPalette.accentGreenPressed

                iconPath: "qrc:/qt/qml/Mentorus/assets/icons/send.png"
                iconHeight: buttonHeight - 10

                visible: hasButton
            }
        }
    }
}

import QtQuick 2.15
import QtQuick.Layouts
import "../theme"

Item {
    id: root

    Layout.preferredHeight: 60
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    ColumnLayout{
        anchors.fill: parent

        spacing: 0

        // Create the Top Bar
        Rectangle {
            id: background

            Layout.fillHeight: true
            Layout.fillWidth: true

            color: ColorPalette.surface

            RowLayout {
                anchors.fill: parent

                spacing: 0

                // Create the tab lable
                Text {
                    id: pageLable

                    Layout.leftMargin: 20
                    Layout.alignment: Qt.AlignVCenter

                    text: "Dashboard"

                    font.family: appFont.name
                    font.pixelSize: 22

                    color: ColorPalette.reallyDark
                }

                // Add space holder
                Item {
                    Layout.fillWidth: true
                }

                LineEdit {
                    id: search

                    Layout.rightMargin: 15
                    Layout.alignment: Qt.AlignVCenter

                    placeHolderText: "Search..."
                    iconPath: "qrc:/qt/qml/Mentorus/assets/icons/search.png"
                }

                // Create the color button
                UiButton {
                    id: colorButton

                    Layout.rightMargin: 15
                    Layout.alignment: Qt.AlignVCenter

                    buttonText: "☾"
                    buttonTextSize: 20

                    buttonHeight: 35
                    buttonWidth: 35

                    buttonFillColor: background.color
                    buttonHoverColor: ColorPalette.reallyLight
                    buttonPressColor: ColorPalette.light
                }

                // Create the settings button
                UiButton {
                    id: settingsButton

                    Layout.rightMargin: 15
                    Layout.alignment: Qt.AlignVCenter

                    buttonText: "🌣"
                    buttonTextSize: 20

                    buttonHeight: 35
                    buttonWidth: 35

                    buttonFillColor: background.color
                    buttonHoverColor: ColorPalette.reallyLight
                    buttonPressColor: ColorPalette.light
                }
            }
        }

        // Add the bottom border
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 2

            color: ColorPalette.midGray
        }
    }
}

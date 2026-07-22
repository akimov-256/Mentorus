import QtQuick 2.15
import QtQuick.Layouts
import "../components"
import "../theme"


Item {
    id: root

    Rectangle {
        id: background

        anchors.fill: parent

        color: "transparent"

        RowLayout {
            anchors.fill: parent

            spacing: 0

            // Previous Chats list
            Rectangle {
                id: chatsList

                Layout.preferredWidth: 300
                Layout.fillHeight: true

                color: ColorPalette.reallyDark
                border.color: ColorPalette.dark
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent

                    // Add the new chat button
                    UiButton {
                        id: newChatButton

                        Layout.margins: 15
                        Layout.alignment: Qt.AlignHCenter

                        buttonHeight: 32
                        buttonWidth: 270

                        buttonFillColor: ColorPalette.accentGreen
                        buttonHoverColor: ColorPalette.accentGreenHover
                        buttonPressColor: ColorPalette.accentGreenPressed

                        buttonText: "New Chat"
                        buttonTextSize: 16
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            // Current Chat
            ColumnLayout {
                id: currentChat

                spacing: 0

                Layout.fillHeight: true
                Layout.fillWidth: true

                TopBar {

                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    color: "transparent"
                }

                // Add the bottom border
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1

                    color: ColorPalette.dark
                }
            }

            // Add the right border
            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 1

                color: ColorPalette.dark
            }
        }
    }
}

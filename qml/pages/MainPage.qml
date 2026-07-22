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

            // Previous Chats list
            Rectangle {
                id: chatsList

                Layout.preferredWidth: 300
                Layout.fillHeight: true

                color: ColorPalette.dark
                border.color: ColorPalette.midGray
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

                        buttonText: "New Chat"
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            // Current Chat
            ColumnLayout {
                id: currentChat

                Layout.fillHeight: true
                Layout.fillWidth: true

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    color: "transparent"
                }
            }
        }
    }
}

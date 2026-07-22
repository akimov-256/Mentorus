import QtQuick 2.15
import QtQuick.Layouts
import "../components"


Item {
    id: root

    property color fillColor
    property color borderColor

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

                color: fillColor
                border.color: borderColor
                border.width: 2

                ColumnLayout {
                    anchors.fill: parent

                    UiButton {
                        id: newChatButton

                        Layout.margins: 15
                        Layout.alignment: Qt.AlignHCenter

                        buttonFillColor: fillColor
                        buttonBorderColor: borderColor

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

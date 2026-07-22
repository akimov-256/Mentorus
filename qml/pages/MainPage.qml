import QtQuick 2.15
import QtQuick.Layouts


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
            }

            // Current Chat
            ColumnLayout {
                id: currentChat

                anchors {
                    top: parent.top
                    right: parent.right
                    left: chatsList.right
                    bottom: parent.bottom
                }

                Rectangle {
                    anchors.fill: parent

                    color: "transparent"
                }
            }
        }
    }
}

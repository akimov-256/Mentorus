import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import "../components"
import "../theme"


Item {
    id: root

    Layout.fillHeight: true
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark

        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        ColumnLayout {
            id: layout

            anchors.fill: parent

            ListView {
                id: chatView

                Layout.topMargin: 10

                Layout.fillWidth: true
                Layout.fillHeight: true

                verticalLayoutDirection: ListView.TopToBottom

                clip: true
                spacing: 10

                visible: count !== 0

                model: chatModel

                delegate: MessageBubble {
                    fromUser: model.fromUser
                    messageText: model.text
                    messageDate: model.date
                }

                onCountChanged: {
                    Qt.callLater(function() {
                        chatView.positionViewAtEnd()
                    })
                }

                ScrollBar.vertical: ScrollBar {
                    policy: chatView.count === 0
                                ? ScrollBar.AlwaysOff
                                : (chatView.count + 2) * 67 + 10 > layout.height ? /* 57 is the height of MessageBubble + 10 for spacing */ ScrollBar.AsNeeded : ScrollBar.AlwaysOff

                    width: 15

                    contentItem: Rectangle {
                        radius: width / 2
                        color: ColorPalette.isLight ? ColorPalette.accentGreenHover : ColorPalette.accentGreenText
                    }

                    background: Rectangle {
                        color: "transparent"
                    }
                }
            }

            // Empty state page
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                visible: chatView.count === 0
                Column {
                    anchors.centerIn: parent

                    spacing: 15

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "How can I help you today?"

                        font.family: appFont.name
                        font.pixelSize: 40
                        font.bold: true

                        color: ColorPalette.isLight ? ColorPalette.reallyDark : ColorPalette.surface
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "Ask any question to get started."

                        font.family: appFont.name
                        font.pixelSize: 20

                        color: ColorPalette.midGray
                    }
                }
            }

            // User typing box
            LineEdit {
                id: userInput

                Layout.fillWidth: true
                Layout.margins: 15
                boxHeignt: 45

                placeHolderText: "Ask anything..."

                inputActive: !aiManager.isGenerating

                onAccepted: {
                    chatModel.appendUserMessage(userInput.userText)
                    aiManager.sendPrompt()
                    userInput.userText = ''
                }
            }
        }
    }
}

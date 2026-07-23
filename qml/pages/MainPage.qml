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

                    SidebarButton {
                        id: dashboard

                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 30
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: true

                        label: "Dashboard"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/home.png"
                    }

                    // Add the new chat button
                    SidebarButton {
                        id: aiChat

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: false

                        label: "AI chat"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/chat.png"
                    }

                    // Add the quiz generator button
                    SidebarButton {
                        id: quizGenerator

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: false

                        label: "Quiz generator"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/quizg.png"
                    }

                    // Add the flashcards button
                    SidebarButton {
                        id: flashcards

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: false

                        label: "Flashcards"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/cardsg.png"
                    }

                    // Add the study planner button
                    SidebarButton {
                        id: studyPlanner

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: false

                        label: "Study planner"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/calendarg.png"
                    }

                    // Add the settings button
                    SidebarButton {
                        id: settings

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: false

                        label: "Settings"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/settingsg.png"
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

                AiChat {

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

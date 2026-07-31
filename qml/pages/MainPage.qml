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

            // Pages area
            Rectangle {
                id: pagesArea

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

                        activated: navigation.currentPage === 0

                        label: "Dashboard"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/home.png"

                        onClicked: navigation.currentPage = 0
                    }

                    // Add the new chat button
                    SidebarButton {
                        id: aiChat

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: navigation.currentPage === 1

                        label: "AI chat"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/chat.png"

                        onClicked: navigation.currentPage = 1
                    }

                    // Add the quiz generator button
                    SidebarButton {
                        id: quizGenerator

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: navigation.currentPage === 2

                        label: "Quiz generator"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/quizg.png"

                        onClicked: navigation.currentPage = 2
                    }

                    // Add the settings button
                    SidebarButton {
                        id: settings

                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: 15
                        Layout.rightMargin: 15

                        activated: navigation.currentPage === 4

                        label: "Settings"
                        iconPath: "qrc:/qt/qml/Mentorus/assets/icons/settingsg.png"

                        onClicked: navigation.currentPage = 4
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            // Current Page
            ColumnLayout {
                id: currentChat

                spacing: 0

                Layout.fillHeight: true
                Layout.fillWidth: true

                TopBar {

                }

                Loader {
                    id: pageLoader

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    source: {
                        switch (navigation.currentPage)
                        {
                        case 0:
                            return "Dashboard.qml"

                        case 1:
                            return "AiChat.qml"

                        case 2:
                            return "QuizLoader.qml"

                        case 4:
                            return "Settings.qml"
                        }
                    }
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

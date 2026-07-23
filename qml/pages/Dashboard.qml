import QtQuick 2.15
import QtQuick.Layouts
import "../theme"
import "../components"


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
            anchors.fill: parent

            spacing: 20

            // Add welcome text
            ColumnLayout {
                Text {
                    Layout.topMargin: 40
                    Layout.leftMargin: 30

                    text: "Welcome back,"

                    font.family: appFont.name
                    font.pixelSize: 32
                    color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
                }

                Text {
                    Layout.leftMargin: 30

                    text: "Pick up where you left off, or start something new."

                    font.family: appFont.name
                    font.pixelSize: 22
                    color: ColorPalette.midGray
                }
            }

            // Create 'Ask anything' button
            UiButton {
                id: askAnything

                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 30
                Layout.rightMargin: 30

                buttonHeight: 60
                buttonWidth: explainLesson.width

                buttonFillColor: ColorPalette.accentGreen
                buttonHoverColor: ColorPalette.accentGreenHover
                buttonPressColor: ColorPalette.accentGreenPressed

                buttonText: "Ask anything"
                buttonTextSize: 22
                buttonTextColor: ColorPalette.accentGreenText

                iconPath: "qrc:/qt/qml/Mentorus/assets/icons/star.png"
            }

            // Create quick action cards
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.rightMargin: 30

                spacing: 20

                QuickActionsCard {
                    id: explainLesson

                    iconPath: "qrc:/qt/qml/Mentorus/assets/icons/book.png"
                    cardText: "Explain lesson"
                }

                QuickActionsCard {
                    id: generateQuiz

                    iconPath: "qrc:/qt/qml/Mentorus/assets/icons/quiz.png"
                    cardText: "Generate quiz"
                }

                QuickActionsCard {
                    id: flashcards

                    iconPath: "qrc:/qt/qml/Mentorus/assets/icons/cards.png"
                    cardText: "Flashcards"
                }

                QuickActionsCard {
                    id: studyPlan

                    iconPath: "qrc:/qt/qml/Mentorus/assets/icons/calendar.png"
                    cardText: "Study plan"
                }
            }

            // Create Stat cards
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.rightMargin: 30

                spacing: 20

                StatCard {
                    id: totalChats

                    cardTitle: "Total chats"
                    cardValue: "83"
                }

                StatCard {
                    id: quizzesDone

                    cardTitle: "Quizzes done"
                    cardValue: "128"
                }

                StatCard {
                    id: cardsLearned

                    cardTitle: "Cards learned"
                    cardValue: "217"
                }

                StatCard {
                    id: studyStreak

                    cardTitle: "Study streak"
                    cardValue: "9 days"
                }
            }

            // Create recent chats and today's plan cards
            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.rightMargin: 30

                spacing: 20

                ListCard {
                    id: recentChats

                    cardTitle: "Recent chats"

                    firstLine: "Photosynthesis basics"
                    secondLine: "Newton's second law"
                }

                ListCard {
                    id: todayPlan

                    cardTitle: "Today's plan"

                    firstLine: "9:00 — Algebra review"
                    secondLine: "14:00 — Chemistry quiz"
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

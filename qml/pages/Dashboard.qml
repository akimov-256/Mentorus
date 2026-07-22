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

            // Add welcome text
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

            // Create quick action cards
            RowLayout {
                Layout.fillWidth: true
                Layout.margins: 30

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

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

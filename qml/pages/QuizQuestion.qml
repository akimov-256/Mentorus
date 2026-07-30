import QtQuick 2.15
import QtQuick.Layouts
import "../theme"
import "../components"


Item {
    id: root

    anchors.fill: parent

    property string subject: "Biology"
    property string difficulty: "Medium"

    // Emitted once the user finishes the last question.
    signal finished(int correctCount, int totalCount)

    property int currentIndex: 0
    readonly property int questionCount: quizModel.questionCount()
    readonly property bool isLastQuestion: currentIndex === questionCount - 1
    property int refresh: 0
    readonly property bool hasAnswer: {
        refresh
        return quizModel.selectedAnswer(currentIndex) !== -1
    }

    Connections {
        target: quizModel
        function onSelectedAnswerChanged() {
            refresh++
        }
    }

    function goPrevious() {
        if (currentIndex > 0) currentIndex -= 1
    }

    function goNext() {
        if (!isLastQuestion) {
            currentIndex += 1
        } else {
            quizManager.finishQuiz()
        }
    }

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
            anchors.margins: 30
            anchors.topMargin: 24

            spacing: 16

            // Tags
            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignHCenter

                PillTag { tagText: root.subject }
                PillTag { tagText: root.difficulty; accented: false }
            }

            // Progress
            ColumnLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 460
                Layout.alignment: Qt.AlignHCenter
                spacing: 6

                ProgressTrack {
                    Layout.fillWidth: true
                    progress: questionCount === 0 ? 0 : (currentIndex + 1) / questionCount
                }

                Text {
                    text: "Question " + (currentIndex + 1) + " of " + questionCount

                    font.family: appFont.name
                    font.pixelSize: 12
                    color: ColorPalette.midGray
                }
            }

            // Question card
            Rectangle {
                Layout.fillWidth: true
                Layout.maximumWidth: 460
                Layout.alignment: Qt.AlignHCenter
                implicitHeight: questionText.implicitHeight + 32
                radius: 10

                color: ColorPalette.isLight
                    ? Qt.darker(ColorPalette.surface, 1.02)
                    : Qt.lighter(ColorPalette.deepDark, 1.35)

                border.width: 1
                border.color: ColorPalette.isLight
                    ? Qt.darker(ColorPalette.surface, 1.08)
                    : Qt.lighter(ColorPalette.deepDark, 1.7)

                Behavior on color { ColorAnimation { duration: 80 } }
                Behavior on border.color { ColorAnimation { duration: 80 } }

                Text {
                    id: questionText

                    x: 16
                    y: 16
                    width: parent.width - 32

                    text: quizModel.question(root.currentIndex)
                    wrapMode: Text.WordWrap

                    font.family: appFont.name
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
                }
            }

            // Options
            ColumnLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 460
                Layout.alignment: Qt.AlignHCenter
                spacing: 8

                Repeater {
                    model: quizModel.options(root.currentIndex)

                    OptionTile {
                        Layout.fillWidth: true
                        optionText: modelData
                        selected: {
                            refresh
                            return quizModel.selectedAnswer(root.currentIndex) === index
                        }
                        onClicked: quizModel.selectAnswer(root.currentIndex, index)
                    }
                }
            }

            // Footer navigation
            RowLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 460
                Layout.alignment: Qt.AlignHCenter

                UiButton {
                    buttonHeight: 40
                    buttonWidth: 96

                    visible: root.currentIndex > 0

                    buttonText: "Previous"
                    buttonTextSize: 15

                    buttonFillColor: ColorPalette.dark
                    buttonHoverColor: ColorPalette.midGray
                    buttonPressColor: ColorPalette.reallyDark

                    onClicked:{
                        root.goPrevious()
                    }
                }

                Item { Layout.fillWidth: true }

                UiButton {
                    buttonHeight: 40
                    buttonWidth: 96

                    buttonActive: root.hasAnswer

                    buttonText: root.isLastQuestion ? "Finish" : "Next"
                    buttonTextSize: 15

                    buttonFillColor: ColorPalette.accentGreen
                    buttonHoverColor: ColorPalette.accentGreenHover
                    buttonPressColor: ColorPalette.accentGreenPressed

                    onClicked:{
                        root.goNext()
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

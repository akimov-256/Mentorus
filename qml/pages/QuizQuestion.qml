import QtQuick 2.15
import QtQuick.Layouts
import "../theme"
import "../components"


Item {
    id: root

    anchors.fill: parent

    // Set these from Main.qml after QuizSetup.generateRequested() resolves,
    // e.g. quizQuestion.subject = "Biology"; quizQuestion.questions = aiResult
    property string subject: "Biology"
    property string difficulty: "Medium"

    // Each entry: { question: string, options: [string, string, string, string], correctIndex: int }
    property var questions: [
        {
            question: "Which organelle is responsible for producing ATP in a cell?",
            options: ["Ribosome", "Mitochondrion", "Golgi apparatus", "Nucleus"],
            correctIndex: 1
        },
        {
            question: "What is the primary pigment used in photosynthesis?",
            options: ["Melanin", "Hemoglobin", "Chlorophyll", "Carotene"],
            correctIndex: 2
        },
        {
            question: "Which process converts glucose into usable cellular energy?",
            options: ["Cellular respiration", "Transcription", "Osmosis", "Meiosis"],
            correctIndex: 0
        }
    ]

    // Emitted once the user finishes the last question.
    signal finished(int correctCount, int totalCount)

    property int currentIndex: 0
    property var selectedOptions: []   // selectedOptions[i] = chosen option index, -1 if unanswered
    readonly property var currentQuestion: questions[currentIndex]
    readonly property bool isLastQuestion: currentIndex === questions.length - 1
    readonly property bool hasAnswer: selectedOptions[currentIndex] !== undefined && selectedOptions[currentIndex] !== -1

    Component.onCompleted: {
        var initial = []
        for (var i = 0; i < questions.length; i++) initial.push(-1)
        selectedOptions = initial
    }

    function selectOption(optionIndex) {
        var updated = selectedOptions.slice()
        updated[currentIndex] = optionIndex
        selectedOptions = updated
    }

    function goPrevious() {
        if (currentIndex > 0) currentIndex -= 1
    }

    function goNext() {
        if (!isLastQuestion) {
            currentIndex += 1
        } else {
            var correct = 0
            for (var i = 0; i < questions.length; i++) {
                if (selectedOptions[i] === questions[i].correctIndex) correct += 1
            }
            root.finished(correct, questions.length)
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
                    progress: (root.currentIndex + 1) / root.questions.length
                }

                Text {
                    text: "Question " + (root.currentIndex + 1) + " of " + root.questions.length

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

                    text: root.currentQuestion.question
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
                    model: root.currentQuestion.options

                    OptionTile {
                        Layout.fillWidth: true
                        optionText: modelData
                        selected: root.selectedOptions[root.currentIndex] === index
                        onClicked: root.selectOption(index)
                    }
                }
            }

            // Footer navigation
            RowLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 460
                Layout.alignment: Qt.AlignHCenter

                Rectangle {
                    implicitWidth: 96
                    implicitHeight: 40
                    radius: 8
                    visible: root.currentIndex > 0

                    color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark
                    border.width: 1
                    border.color: ColorPalette.isLight
                        ? Qt.darker(ColorPalette.surface, 1.08)
                        : Qt.lighter(ColorPalette.deepDark, 1.7)

                    Text {
                        anchors.centerIn: parent
                        text: "Previous"
                        font.family: appFont.name
                        font.pixelSize: 13
                        color: ColorPalette.midGray
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.goPrevious()
                    }
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    implicitWidth: 96
                    implicitHeight: 40
                    radius: 8

                    opacity: root.hasAnswer ? 1.0 : 0.5

                    color: nextArea.pressed
                        ? ColorPalette.accentGreenPressed
                        : (nextArea.containsMouse ? ColorPalette.accentGreenHover : ColorPalette.accentGreen)

                    Behavior on color { ColorAnimation { duration: 80 } }

                    Text {
                        anchors.centerIn: parent
                        text: root.isLastQuestion ? "Finish" : "Next"
                        font.family: appFont.name
                        font.pixelSize: 13
                        font.weight: Font.Medium
                        color: ColorPalette.accentGreenText
                    }

                    MouseArea {
                        id: nextArea
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: root.hasAnswer
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.goNext()
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

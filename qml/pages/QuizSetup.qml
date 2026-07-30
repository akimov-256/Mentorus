import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "../theme"
import "../components"


Item {
    id: root

    anchors.fill: parent

    signal generateRequested(string subject, string topic, string difficulty, int questionCount)

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

            spacing: 24

            // Intro text
            ColumnLayout {
                spacing: 4

                Text {
                    text: "Generate a quiz"

                    font.family: appFont.name
                    font.pixelSize: 26
                    color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
                }

                Text {
                    text: "Pick a subject and topic, and the AI will put together questions for you."

                    font.family: appFont.name
                    font.pixelSize: 15
                    color: ColorPalette.midGray
                }
            }

            // Setup form
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: formColumn.implicitHeight + 32
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

                ColumnLayout {
                    id: formColumn

                    x: 16
                    y: 16
                    width: parent.width - 32
                    spacing: 18

                    LabeledField {
                        fieldLabel: "Topic"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 35
                        Layout.bottomMargin: 10


                        RowLayout {
                            anchors.fill: parent

                            LineEdit {
                                id: topicField

                                Layout.fillWidth: true
                                boxHeignt: 35

                                textPixelSize: 12
                                placeHolderText: "e.g. Cell respiration"

                                hasButton: false
                            }
                        }
                    }


                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16
                        Layout.bottomMargin: 10

                        LabeledField {
                            fieldLabel: "Difficulty"
                            Layout.fillWidth: true

                            FormComboBox {
                                id: difficultyField
                                Layout.fillWidth: true
                                model: ["Easy", "Medium", "Hard"]
                                currentIndex: 1
                            }
                        }

                        LabeledField {
                            fieldLabel: "Number of questions (3-30)"
                            Layout.fillWidth: true

                            SpinBox {
                                id: questionCountField
                                Layout.fillWidth: true
                                implicitHeight: 36
                                from: 3
                                to: 30
                                value: 10
                                editable: true

                                contentItem: TextInput {
                                    text: parent.textFromValue(parent.value, parent.locale)
                                    font.family: appFont.name
                                    font.pixelSize: 13
                                    color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter
                                    readOnly: !parent.editable
                                    validator: parent.validator
                                }

                                background: Rectangle {
                                    radius: 6
                                    color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark
                                    border.width: 1
                                    border.color: ColorPalette.isLight
                                        ? Qt.darker(ColorPalette.surface, 1.08)
                                        : Qt.lighter(ColorPalette.deepDark, 1.7)
                                }

                                up.indicator: Item {}
                                down.indicator: Item {}
                            }
                        }
                    }

                    // Generate button
                    UiButton {
                        id: generateButton

                        buttonHeight: 46
                        buttonWidth: 160

                        buttonActive: topicField.userText !== ""

                        buttonText: "Generate Quiz"
                        buttonTextSize: 15

                        buttonFillColor: ColorPalette.accentGreen
                        buttonHoverColor: ColorPalette.accentGreenHover
                        buttonPressColor: ColorPalette.accentGreenPressed

                        onClicked:{
                            quizManager.generateQuiz(topicField.userText, difficultyField.currentText, questionCountField.value)
                        }
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

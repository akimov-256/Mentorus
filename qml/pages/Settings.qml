import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "../theme"
import "../components"


Item {
    id: root

    anchors.fill: parent

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

        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: column.implicitHeight + 60
            boundsBehavior: Flickable.StopAtBounds
            clip: true

            ColumnLayout {
                id: column

                x: 30
                y: 30
                width: parent.width - 60
                spacing: 16

                // General
                SettingsCard {
                    cardTitle: "General"

                    SettingsRow {
                        rowLabel: "Theme"

                        RowLayout {
                            spacing: 2

                            Rectangle {
                                implicitWidth: 52
                                implicitHeight: 26
                                radius: 6
                                color: ColorPalette.isLight
                                    ? (ColorPalette.isLight ? Qt.darker(ColorPalette.surface, 1.02) : "transparent")
                                    : "transparent"
                                border.width: ColorPalette.isLight ? 1 : 0
                                border.color: Qt.darker(ColorPalette.surface, 1.08)

                                Text {
                                    anchors.centerIn: parent
                                    text: "Light"
                                    font.family: appFont.name
                                    font.pixelSize: 12
                                    color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.midGray
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        ColorPalette.isLight = true
                                        settingsManager.setThemeMode(ColorPalette.isLight)
                                    }
                                }
                            }

                            Rectangle {
                                implicitWidth: 52
                                implicitHeight: 26
                                radius: 6
                                color: !ColorPalette.isLight ? ColorPalette.accentGreenPressed : "transparent"

                                Text {
                                    anchors.centerIn: parent
                                    text: "Dark"
                                    font.family: appFont.name
                                    font.pixelSize: 12
                                    color: !ColorPalette.isLight ? ColorPalette.reallyLight : ColorPalette.midGray
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        ColorPalette.isLight = false
                                        settingsManager.setThemeMode(ColorPalette.isLight)
                                    }
                                }
                            }
                        }
                    }

                    SettingsRow {
                        rowLabel: "Language"

                        SettingsComboBox {
                            model: ["English"]
                        }
                    }
                }

                // AI
                SettingsCard {
                    cardTitle: "AI"

                    SettingsRow {
                        rowLabel: "API key"

                        Text {
                            text: settingsManager.getAPIKey() === "" ? "Key not found" : "Key found"
                            color: settingsManager.getAPIKey() === "" ? "#ff0000" : "#00ff00"

                            font.family: appFont.name
                            font.pixelSize: 12
                        }

                        LineEdit {
                            id: apiKey

                            boxHeignt: 25
                            boxWidth: 350

                            textPixelSize: 12

                            hasButton: false

                            placeHolderText: "Paste your API key here..."

                            onTextChanged: {
                                settingsManager.setAPIKey(apiKey.userText)
                            }
                        }
                    }

                    SettingsRow {
                        rowLabel: "Model"

                        SettingsComboBox {
                            model: ["Llama 3.3"]
                        }
                    }

                    SettingsRow {
                        rowLabel: "Max messages loaded on prompt"

                        LineEdit {
                            id: maxMessages

                            boxHeignt: 25
                            boxWidth: 80

                            textPixelSize: 12

                            hasButton: false

                            userText: settingsManager.getMaxHistory()

                            onUserTextChanged: {
                                settingsManager.setMaxHistory(userText)
                            }
                        }
                    }
                }

                // Application
                SettingsCard {
                    cardTitle: "Application"

                    SettingsRow {
                        rowLabel: "Clear history"

                        UiButton {
                            id: clearHistory

                            buttonHeight: 25
                            buttonWidth: 60

                            buttonFillColor: ColorPalette.accentGreen
                            buttonHoverColor: ColorPalette.accentGreenHover
                            buttonPressColor: ColorPalette.accentGreenPressed

                            buttonText: "Clear"
                            buttonTextSize: 12
                            buttonTextColor: ColorPalette.accentGreenText

                            onClicked: chatModel.clearHistory()
                        }
                    }

                    SettingsRow {
                        rowLabel: "About"

                        Text {
                            text: "Mentorus"
                            font.family: appFont.name
                            font.pixelSize: 13
                            color: ColorPalette.midGray
                        }
                    }

                    SettingsRow {
                        rowLabel: "Version"

                        Text {
                            text: "v0.0.0"
                            font.family: appFont.name
                            font.pixelSize: 13
                            color: ColorPalette.midGray
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }

    // Shared dropdown styling for the page.
    component SettingsComboBox: ComboBox {
        implicitWidth: 150

        background: Rectangle {
            radius: 6
            color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark
            border.width: 1
            border.color: ColorPalette.isLight
                ? Qt.darker(ColorPalette.surface, 1.08)
                : Qt.lighter(ColorPalette.deepDark, 1.7)
        }

        contentItem: Text {
            text: parent.displayText
            font.family: appFont.name
            font.pixelSize: 13
            color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
            leftPadding: 10
            verticalAlignment: Text.AlignVCenter
        }
    }
}
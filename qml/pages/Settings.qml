import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "../theme"
import "../components"


Item {
    id: root

    anchors.fill: parent

    signal clearHistoryRequested()
    signal clearCacheRequested()

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
                                    onClicked: ColorPalette.isLight = true
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
                                    onClicked: ColorPalette.isLight = false
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

                        LineEdit {
                            id: apiKey

                            boxHeignt: 25
                            boxWidth: 350

                            textPixelSize: 12

                            hasButton: false

                            placeHolderText: "Paste your API key here..."
                        }
                    }

                    SettingsRow {
                        rowLabel: "Model"

                        SettingsComboBox {
                            model: ["Llama 3.3"]
                        }
                    }

                    SettingsRow {
                        rowLabel: "Temperature"

                        Slider {
                            implicitWidth: 130
                            from: 0
                            to: 1
                            value: 0.55

                            background: Rectangle {
                                x: parent.leftPadding
                                y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                width: parent.availableWidth
                                height: 5
                                radius: 3
                                color: ColorPalette.isLight
                                    ? Qt.darker(ColorPalette.surface, 1.08)
                                    : Qt.lighter(ColorPalette.deepDark, 1.7)

                                Rectangle {
                                    width: parent.parent.visualPosition * parent.width
                                    height: parent.height
                                    radius: 3
                                    color: ColorPalette.accentGreen
                                }
                            }

                            handle: Rectangle {
                                x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
                                y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                implicitWidth: 15
                                implicitHeight: 15
                                radius: 8
                                color: ColorPalette.accentGreen
                            }
                        }
                    }

                    SettingsRow {
                        rowLabel: "Max tokens"

                        LineEdit {
                            id: maxTokens

                            boxHeignt: 25
                            boxWidth: 80

                            textPixelSize: 12

                            hasButton: false
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

                            onClicked: root.clearHistoryRequested()
                        }
                    }

                    SettingsRow {
                        rowLabel: "Clear cache"

                        UiButton {
                            id: clearCache

                            buttonHeight: 25
                            buttonWidth: 60

                            buttonFillColor: ColorPalette.accentGreen
                            buttonHoverColor: ColorPalette.accentGreenHover
                            buttonPressColor: ColorPalette.accentGreenPressed

                            buttonText: "Clear"
                            buttonTextSize: 12
                            buttonTextColor: ColorPalette.accentGreenText

                            onClicked: root.clearCacheRequested()
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
                            text: "0.1.0"
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
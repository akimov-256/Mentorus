import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "components"
import "pages"
import "theme"


ApplicationWindow {
    id: root
    width: 1280
    height: 720
    minimumWidth: 200
    minimumHeight: 250
    visible: true
    title: "Mentorus"
    property bool lightMode: Application.styleHints.colorScheme === Qt.Light

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    flags: Qt.Window | Qt.FramelessWindowHint

    onWindowStateChanged: {
        isMaximized = (visibility === Window.Maximized)
    }

    Rectangle {
        id: titleBar

        width: parent.width
        height: 26.25

        color: ColorPalette.reallyDark

        // Add title bar content
        RowLayout {
            id: titleBarLayout

            anchors.fill: parent
            anchors.leftMargin: 10

            // Add the app name
            Text {
                id: appName
                text: "MENTORUS"
                font.family: appFont.name
                font.pixelSize: 15
                color: "#ffffff"
                Layout.alignment: Qt.AlignVCenter
            }

            // Add spacer
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                // Handle window movement and maximizing/minimizing
                MouseArea {
                    anchors.fill: parent
                    property point clickPos: "0,0"

                    onPressed: (mouse) => {
                        root.startSystemMove()
                    }

                    onDoubleClicked: (mouse) => {
                        if (root.isMaximized)
                            root.showNormal()
                        else
                            root.showMaximized()
                    }
                }
            }

            // Add window control buttons
            RowLayout {
                spacing: 0

                Layout.alignment: Qt.AlignVCenter

                WindowButton {
                    id: minimize
                    buttonIcon: "qrc:/qt/qml/Mentorus/assets/icons/minimize.png"
                    onClicked: root.showMinimized()
                }

                WindowButton {
                    id: maximize
                    buttonIcon: root.isMaximized ? "qrc:/qt/qml/Mentorus/assets/icons/restore.png" : "qrc:/qt/qml/Mentorus/assets/icons/maximize.png"
                    onClicked:
                    {
                        if (root.isMaximized)
                            root.showNormal()
                        else
                            root.showMaximized()
                    }
                }

                WindowButton {
                    id: close
                    buttonIcon: "qrc:/qt/qml/Mentorus/assets/icons/close.png"
                    hoverColor: "#ff0000"
                    clickColor: "#700000"
                    onClicked: root.close()
                }
            }
        }
    }

    Rectangle {
        id: background

        anchors {
            top: titleBar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }

        color: light

        MainPage {
            anchors.fill: parent
        }
    }
}

import QtQuick 2.15
import QtQuick.Layouts


Item {
    id: root

    property color buttonFillColor
    property color buttonHoverColor
    property color buttonPressColor
    property color buttonTextColor
    property int buttonHeight
    property int buttonWidth
    property int iconHeight
    property string buttonText
    property int buttonTextSize
    property string iconPath

    signal clicked()

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Layout.preferredHeight: buttonHeight
    Layout.preferredWidth: buttonWidth

    Rectangle {
        anchors.fill: parent

        // Handle color and scale when actions are detected
        color: mouseArea.pressed ? buttonPressColor : mouseArea.containsMouse ? buttonHoverColor : buttonFillColor
        scale: mouseArea.pressed ? 0.99 : 1.0

        radius: 5

        // Handle transitions
        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 50
            }
        }

        // Detect pressing and hovering
        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                root.clicked();
            }
        }

        RowLayout {
            anchors.centerIn: parent

            Item {
                Layout.fillWidth: true
            }

            // Set button icon
            Image {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredHeight: iconHeight
                Layout.preferredWidth: iconHeight

                source: iconPath

                visible: iconPath !== ""
            }

            // Set button text
            Text {
                Layout.alignment: Qt.AlignVCenter

                text: buttonText

                font.family: appFont.name
                font.pixelSize: buttonTextSize
                color: buttonTextColor
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }
}

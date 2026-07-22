import QtQuick 2.15
import QtQuick.Layouts


Item {
    id: root

    property color buttonFillColor
    property color buttonBorderColor
    property int buttonHeight
    property int buttonWidth
    property string buttonText

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
        color: mouseArea.pressed ? Qt.darker(buttonFillColor, 1.2) : mouseArea.containsMouse ? Qt.lighter(buttonFillColor, 1.2) : buttonFillColor
        scale: mouseArea.pressed ? 0.99 : 1.0

        border.color: buttonBorderColor
        border.width: 2
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

        // Set button text
        Text {
            anchors.centerIn: parent

            text: buttonText

            font.family: appFont.name
            font.pixelSize: 16
            color: "#000000"
        }
    }
}

import QtQuick 2.15
import QtQuick.Layouts


Item {
    id: root

    property color buttonFillColor
    property color buttonBorderColor
    property int buttonHeight
    property int buttonWidth
    property string buttonText

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Layout.preferredHeight: buttonHeight
    Layout.preferredWidth: buttonWidth

    Rectangle {
        anchors.fill: parent

        color: buttonFillColor
        border.color: buttonBorderColor
        border.width: 2
        radius: 5

        Text {
            anchors.centerIn: parent

            text: buttonText

            font.family: appFont.name
            font.pixelSize: 16
            color: "#000000"
        }
    }
}

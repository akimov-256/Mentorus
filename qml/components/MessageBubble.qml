import QtQuick 2.15
import QtQuick.Layouts
import "../theme"


Item {
    id: root

    property bool fromUser: true
    property string messageText
    property string messageDate

    implicitHeight: messageTextLabel.implicitHeight + 41 // 24 for the content margins + 12 for the date text height + 5 for the spacing
    width: Math.min(messageTextLabel.implicitWidth + 24, parent.width * 0.7)

    anchors {
        right: fromUser ? parent.right : undefined
        left: fromUser ? undefined : parent.left
        topMargin: 15
        leftMargin: 15
        rightMargin: 30
        bottomMargin: 15
    }

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        anchors.fill: parent

        color: "transparent"

        ColumnLayout {
            anchors.fill: parent

            Rectangle {
                id: background

                Layout.fillHeight: true
                Layout.fillWidth: true

                color: ColorPalette.isLight ? fromUser ? ColorPalette.accentGreenSoft : ColorPalette.reallyLight : fromUser ? ColorPalette.accentGreenPressed : ColorPalette.reallyDark
                border.color: fromUser ? "transparent" : ColorPalette.isLight ? ColorPalette.light : ColorPalette.dark
                border.width: 1

                radius: 10

                Behavior on color {
                    ColorAnimation {
                        duration: 80
                    }
                }

                Text {
                    id: messageTextLabel

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 12

                    width: parent.width - 24

                    text: messageText

                    color: ColorPalette.isLight ? ColorPalette.reallyDark : ColorPalette.surface
                    font.family: appFont.name
                    font.pixelSize: 16
                    wrapMode: Text.WordWrap
                }
            }

            Text {
                id: msgDate

                Layout.alignment: fromUser? Qt.AlignRight : Qt.AlignLeft

                text: messageDate

                color: ColorPalette.midGray
                font.family: appFont.name
                font.pixelSize: 12
            }
        }
    }
}

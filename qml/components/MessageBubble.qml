import QtQuick 2.15
import QtQuick.Layouts
import "../theme"


Item {
    id: root

    property bool fromUser: true

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
            }
        }
    }
}

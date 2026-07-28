import QtQuick 2.15
import QtQuick.Controls.Basic
import "../theme"

// Styled ComboBox used across form-style pages (Quiz setup, Settings, etc.)
ComboBox {
    id: root

    implicitWidth: 160
    implicitHeight: 36

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    background: Rectangle {
        radius: 6
        color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark
        border.width: 1
        border.color: ColorPalette.isLight
            ? Qt.darker(ColorPalette.surface, 1.08)
            : Qt.lighter(ColorPalette.deepDark, 1.7)
    }

    contentItem: Text {
        text: root.displayText
        font.family: appFont.name
        font.pixelSize: 13
        color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
    }
}

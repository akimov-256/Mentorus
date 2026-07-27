import QtQuick 2.15
import QtQuick.Layouts
import "../theme"

// A titled, bordered section grouping several SettingRow items.
// Usage:
//   SettingsCard {
//       cardTitle: "General"
//       SettingRow { ... }
//       SettingRow { ... }
//   }
Rectangle {
    id: root

    default property alias content: contentColumn.data
    property string cardTitle: ""

    Layout.fillWidth: true
    implicitHeight: contentColumn.implicitHeight + 28

    radius: 10

    // NOTE: derived from confirmed ColorPalette members since the exact
    // card-surface / card-border property names weren't visible to me.
    // Swap these for real ColorPalette properties if you have dedicated ones.
    color: ColorPalette.isLight
        ? Qt.darker(ColorPalette.surface, 1.02)
        : Qt.lighter(ColorPalette.deepDark, 1.35)

    border.width: 1
    border.color: ColorPalette.isLight
        ? Qt.darker(ColorPalette.surface, 1.08)
        : Qt.lighter(ColorPalette.deepDark, 1.7)

    Behavior on color { ColorAnimation { duration: 80 } }
    Behavior on border.color { ColorAnimation { duration: 80 } }

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    ColumnLayout {
        id: contentColumn

        x: 14
        y: 14
        width: parent.width - 28
        spacing: 2

        Text {
            Layout.bottomMargin: 8

            text: root.cardTitle.toUpperCase()

            font.family: appFont.name
            font.pixelSize: 12
            font.letterSpacing: 0.5
            color: ColorPalette.midGray
        }
    }
}

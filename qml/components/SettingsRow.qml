import QtQuick 2.15
import QtQuick.Layouts
import "../theme"

// A single labeled settings row. Place the control (Text, ComboBox,
// Slider, UiButton, etc.) as the row's child.
// Usage:
//   SettingRow {
//       rowLabel: "Font size"
//       ComboBox { model: ["Small", "Medium", "Large"] }
//   }
RowLayout {
    id: root

    default property alias control: controlHolder.data
    property string rowLabel: ""

    Layout.fillWidth: true
    Layout.preferredHeight: 36

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Text {
        text: root.rowLabel

        font.family: appFont.name
        font.pixelSize: 15
        color: ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight
    }

    Item { Layout.fillWidth: true }

    RowLayout {
        id: controlHolder
        spacing: 8
    }
}

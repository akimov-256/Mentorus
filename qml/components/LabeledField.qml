import QtQuick 2.15
import QtQuick.Layouts
import "../theme"

// A form field with a small label above the control.
// Usage:
//   LabeledField {
//       fieldLabel: "Subject"
//       ComboBox { model: [...] }
//   }
ColumnLayout {
    id: root

    default property alias control: controlHolder.data
    property string fieldLabel: ""

    spacing: 4

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Text {
        text: root.fieldLabel

        font.family: appFont.name
        font.pixelSize: 11
        color: ColorPalette.midGray
    }

    RowLayout {
        id: controlHolder
        spacing: 0
    }
}

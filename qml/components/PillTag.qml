import QtQuick 2.15
import "../theme"

// Small rounded label used for the subject/difficulty tags on the quiz page.
// Usage: PillTag { tagText: "Biology" }
//        PillTag { tagText: "Medium"; accented: false }
Rectangle {
    id: root

    property string tagText: ""
    property bool accented: true

    implicitWidth: label.implicitWidth + 18
    implicitHeight: 22
    radius: 6

    // NOTE: no confirmed "tint" swatch on ColorPalette was visible to me,
    // so the light-mode accented fill is approximated with Qt.lighter().
    // Swap for a real ColorPalette.accentGreenTint if one exists.
    color: accented
        ? (ColorPalette.isLight ? Qt.lighter(ColorPalette.accentGreenPressed, 1.9) : ColorPalette.accentGreenPressed)
        : (ColorPalette.isLight ? Qt.darker(ColorPalette.surface, 1.08) : Qt.lighter(ColorPalette.deepDark, 1.7))

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Text {
        id: label
        anchors.centerIn: parent

        text: root.tagText

        font.family: appFont.name
        font.pixelSize: 11
        color: root.accented
            ? (ColorPalette.isLight ? ColorPalette.accentGreenText : ColorPalette.reallyLight)
            : ColorPalette.midGray
    }
}

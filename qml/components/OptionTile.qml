import QtQuick 2.15
import QtQuick.Layouts
import "../theme"

// A single selectable answer option in the quiz question card.
// Usage:
//   OptionTile {
//       optionText: "Mitochondrion"
//       selected: root.selectedIndex === 1
//       onClicked: root.selectedIndex = 1
//   }
Rectangle {
    id: root

    signal clicked()

    property string optionText: ""
    property bool selected: false

    Layout.fillWidth: true
    implicitHeight: 42
    radius: 8

    color: selected
        ? (ColorPalette.isLight ? Qt.lighter(ColorPalette.accentGreenPressed, 1.9) : ColorPalette.accentGreenPressed)
        : (ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark)

    border.width: selected ? 1.5 : 1
    border.color: selected
        ? ColorPalette.accentGreen
        : (ColorPalette.isLight ? Qt.darker(ColorPalette.surface, 1.08) : Qt.lighter(ColorPalette.deepDark, 1.7))

    Behavior on color { ColorAnimation { duration: 80 } }
    Behavior on border.color { ColorAnimation { duration: 80 } }

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.verticalCenter: parent.verticalCenter

        text: root.optionText

        font.family: appFont.name
        font.pixelSize: 14
        color: root.selected
            ? (ColorPalette.isLight ? ColorPalette.accentGreenText : ColorPalette.reallyLight)
            : (ColorPalette.isLight ? ColorPalette.deepDark : ColorPalette.reallyLight)
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}

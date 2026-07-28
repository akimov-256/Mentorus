import QtQuick 2.15
import "../theme"

// A slim progress bar. progress is 0.0 - 1.0.
// Usage: ProgressTrack { progress: 0.4 }
Rectangle {
    id: root

    property real progress: 0

    implicitHeight: 6
    radius: 3
    color: ColorPalette.isLight ? Qt.darker(ColorPalette.surface, 1.08) : Qt.lighter(ColorPalette.deepDark, 1.7)

    Rectangle {
        width: parent.width * Math.max(0, Math.min(1, root.progress))
        height: parent.height
        radius: parent.radius
        color: ColorPalette.accentGreen

        Behavior on width { NumberAnimation { duration: 150 } }
    }
}

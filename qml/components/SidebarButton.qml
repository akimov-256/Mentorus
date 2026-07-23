import QtQuick 2.15
import QtQuick.Layouts
import "../theme"


Item {
    id: root

    property string label
    property string iconPath
    property bool activated: false

    signal clicked()

    height: 40
    width: 270

    Rectangle {
        anchors.fill: parent

        // Handle color and scale when actions are detected
        color: activated ? mouseArea.pressed ? ColorPalette.accentGreenPressed : ColorPalette.accentGreenHover : mouseArea.containsMouse ? ColorPalette.dark : ColorPalette.reallyDark

        radius: 5

        // Handle transitions
        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        // Detect pressing and hovering
        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                root.clicked();
            }
        }

        RowLayout {
            anchors.fill: parent

            spacing: 10

            // Set button icon
            Image {
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 15

                Layout.preferredHeight: 20
                Layout.preferredWidth: 20

                source: iconPath
            }

            // Set button text
            Text {
                Layout.alignment: Qt.AlignVCenter

                text: label

                font.family: appFont.name
                font.pixelSize: 18
                color: ColorPalette.accentGreenTint
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }
}

import QtQuick 2.15
import QtQuick.Layouts
import "../components"
import "../theme"


Item {
    id: root

    Layout.fillHeight: true
    Layout.fillWidth: true

    FontLoader {
        id: appFont
        source: "qrc:/qt/qml/Mentorus/assets/fonts/Lexend.ttf"
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: ColorPalette.isLight ? ColorPalette.surface : ColorPalette.deepDark

        Behavior on color {
            ColorAnimation {
                duration: 80
            }
        }

        ColumnLayout {
            anchors.fill: parent

            Item {
                Layout.fillHeight: true
            }

            LineEdit {
                id: search

                Layout.fillWidth: true
                Layout.margins: 15
                boxHeignt: 45


                placeHolderText: "Ask anything..."
            }
        }
    }
}

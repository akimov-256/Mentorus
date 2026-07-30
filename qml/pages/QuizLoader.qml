import QtQuick 2.15

Item {
    id: root

    property int page: 0

    Connections {
        target: quizManager

        function onQuizGenerated() {
            root.page = 1
        }

        function onQuizFinished(score, total) {
            root.page = 0
        }
    }

    Loader {
        id: quizLoader

        anchors.fill: parent

        source: {
            switch (root.page)
            {
            case 0:
                return "QuizSetup.qml"

            case 1:
                return "QuizQuestion.qml"
            }
        }
    }
}

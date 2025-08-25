import QtQuick

Item {
    id: topBar

    Timer {
      id: dateTimeTimer
      interval: 30000 //30s
      repeat: true
      running: true
      onTriggered: {
           DateTimeProvider.refreshDateTime();
      }
    }

    Component.onCompleted: {
        DateTimeProvider.refreshDateTime();
    }

    Text {
        id: dateTimeText
        text: DateTimeProvider.dateTime
        color: "#ffffff"
        //font.pixelSize: 25
        font: Qt.font({
                        unicodeCoverage: [Font.UnicodeBlock_BasicLatin], // << define character set
                        pixelSize: 25
                    })
        anchors {
            left: topBarLineRect.left
            leftMargin: 5
        }
    }

    Rectangle {
        id: topBarLineRect
        width: topBar.width * 0.9
        height: 2
        anchors {
            top: dateTimeText.bottom
            left: parent.left
            topMargin: 5

        }
    }
}

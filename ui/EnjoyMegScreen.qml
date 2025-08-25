import QtQuick

Rectangle {
  id: thankYouScreen
  color: "transparent"

  Timer {
    id: finishTimer
    interval: 2000
    running: false
    onTriggered: {
      SystemInterface.clearSelectedDrink()
      SystemInterface.currentPage = "ui/HotCoolSelectScreen.qml"
    }
  }

  Component.onCompleted: finishTimer.start()

  Rectangle {
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      top: parent.top
      topMargin: 10
      bottomMargin: 10
    }

    width: parent.width * 0.5
    color: "transparent"

    Image {
      id: drinkImg
      source: "file://" + SystemInterface.selectedDrinkGlassImage

      anchors.fill: parent
      fillMode: Image.Pad
    }
  }

  Rectangle {
    anchors {
      verticalCenter: parent.verticalCenter
      right: parent.right
      top: parent.top
      topMargin: 10
      bottomMargin: 10
    }

    width: parent.width * 0.5
    color: "transparent"

    Image {
      id: checkImg
      source: "file://035.png"
      anchors.centerIn: parent
    }

    Text {
      id: enjoyText
      text: qsTr("Enjoy your drink!")
      color: "white"
      font.pixelSize: 40
      anchors {
        horizontalCenter: parent.horizontalCenter

        top: checkImg.bottom
        bottomMargin: 30
      }
    }
  }
}

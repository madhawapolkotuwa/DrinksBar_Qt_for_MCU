import QtQuick

Rectangle {
  id: confirmationScreen
  color: "transparent"

  Rectangle {
    id: imageContainerRect
    anchors {
      left: parent.left
      top: parent.top
      bottom: parent.bottom
    }

    width: parent.width / 3
    color: "transparent"

    Image {
      id: drinkImg
      source: "file://" + SystemInterface.selectedDrinkGlassImage
      fillMode: Image.Pad
      anchors.centerIn: parent
    }
  }

  Rectangle {
    id: drinkInformationRect
    height: parent.height
    width: parent.width / 3 + 20
    anchors {
      left: imageContainerRect.right
    }

    color: "transparent"

    Rectangle {
      width: parent.width
      height: parent.height * 0.8
      anchors.centerIn: parent
      radius: 5
      color: "black"

      Rectangle {
        id: drinkTypeRect
        width: parent.width
        height: parent.height / 4
        anchors.top: parent.top
        color: "transparent"

        Text {
          anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
          }

          text: {
            if (SystemInterface.currentDrinkType === 0) {
              return qsTr("Hot Drink")
            } else if (SystemInterface.currentDrinkType === 1) {
              return qsTr("Cool Drink")
            } else if (SystemInterface.currentDrinkType === 2) {
              return qsTr("Fresh Juice")
            }
          }

          color: "white"
          font.pixelSize: 30
        }
      }

      Rectangle {
        width: parent.width * 0.9
        height: 1
        color: "white"
        anchors {
          top: drinkTypeRect.bottom
          horizontalCenter: parent.horizontalCenter
        }
      }

      Rectangle {
        id: drinkNameRect
        width: parent.width
        height: parent.height / 4
        anchors.top: drinkTypeRect.bottom
        color: "transparent"

        Text {
          anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
          }

          text: SystemInterface.selectedDrinkName
          color: "white"
          font.pixelSize: 30
        }
      }

      Rectangle {
        width: parent.width * 0.9
        height: 1
        color: "white"
        anchors {
          top: drinkNameRect.bottom
          horizontalCenter: parent.horizontalCenter
        }
      }

      Rectangle {
        id: drinkSizeRect
        width: parent.width
        height: parent.height / 4
        anchors.top: drinkNameRect.bottom
        color: "transparent"

        Text {
          anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
          }

          text: {
            if (SystemInterface.size === 2) {
              return qsTr("Small Size")
            } else if (SystemInterface.size === 1) {
              return qsTr("Medium Size")
            } else if (SystemInterface.size === 0) {
              return qsTr("Large Size")
            }
          }

          color: "white"
          font.pixelSize: 30
        }
      }

      Rectangle {
        width: parent.width * 0.9
        height: 1
        color: "white"
        anchors {
          top: drinkSizeRect.bottom
          horizontalCenter: parent.horizontalCenter
        }
      }

      Rectangle {
        id: sugarLevelRect
        width: parent.width
        height: parent.height / 4
        anchors.top: drinkSizeRect.bottom
        color: "transparent"

        Text {
          anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
          }

          text: SystemInterface.sugarLevelText

          color: "white"
          font.pixelSize: 30
        }
      }
    }
  }

  Rectangle {
    id: startImageContainer
    width: parent.width / 3 - 20
    anchors {
      left: drinkInformationRect.right
      top: parent.top
      bottom: parent.bottom
    }

    color: "transparent"

    Rectangle {
      id: imageRect
      width: 200
      height: 200
      anchors.centerIn: parent
      radius: 50
      color: "transparent"
      Image {
        id: startImg
        source: "file://037.png"
        fillMode: Image.Pad
        anchors.centerIn: parent
      }

      MouseArea {
        anchors.fill: parent

        onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
        onReleased: parent.color = "transparent"

        onClicked: {
          //stackView.push("PreparingDrinkScreen.qml")
          SystemInterface.currentPage = "ui/PreparingDrinkScreen.qml"
        }
      }
    }
  }

  Rectangle {
    id: backBtnRect

    anchors {
      left: parent.left
      leftMargin: 30
      bottom: parent.bottom
    }

    width: 200
    height: 64

    color: "transparent"

    Image {
      id: backBtnImge
      source: "file://034.png"
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }

      fillMode: Image.PreserveAspectFit
    }

    Text {
      id: backBtnText
      text: qsTr("Back")
      color: "#ffffff"
      anchors {
        left: backBtnImge.right
        leftMargin: 10
        verticalCenter: parent.verticalCenter
      }
    }

    MouseArea {
      anchors.fill: parent

      onClicked: {
        if (SystemInterface.currentDrinkType === 0) {
          SystemInterface.currentPage = "ui/SugarLevelSelectScreen.qml"
        } else {
          SystemInterface.currentPage = "ui/SizeSelectScreen.qml"
        }
      }
    }
  }
}

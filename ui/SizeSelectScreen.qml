import QtQuick

Rectangle {
  id: drinkSizeSelectScreen
  color: "transparent"

  Rectangle {
    anchors {
      left: parent.left
      top: parent.top
      bottom: parent.bottom
    }

    width: parent.width * 0.5
    color: "transparent"

    Image {
      id: drinkImg
      source: "file://" + SystemInterface.selectedDrinkGlassImage
      fillMode: Image.Pad
      anchors.centerIn: parent
    }
  }

  Rectangle {
    id: sizeSelectContainerRect
    width: parent.width * 0.5
    anchors {
      right: parent.right
      top: parent.top
      bottom: parent.bottom
      topMargin: 40
      bottomMargin: 40
    }

    color: "transparent"

    Rectangle {
      id: sizeSelectPanelRect
      anchors.fill: parent
      anchors.margins: 10

      radius: 10
      color: "#404040"

      Text {
        id: sizeTitleTxt
        text: qsTr("Size")
        color: "white"
        anchors {
          top: parent.top
          topMargin: 5
          horizontalCenter: parent.horizontalCenter
        }
        font.pixelSize: 40
      }

      Rectangle {
        id: selectPannelInnerRect
        anchors {
          top: sizeTitleTxt.bottom
          bottom: parent.bottom
        }

        width: parent.width
        color: "transparent"

        function onSizeSelect() {
          if (SystemInterface.currentDrinkType === 0) {
            SystemInterface.currentPage = "ui/SugarLevelSelectScreen.qml"
          } else {
            SystemInterface.currentPage = "ui/ConfirmationScreen.qml"
          }
        }

        Rectangle {
          id: largeSizeBtnRect
          height: parent.height / 3
          width: parent.width
          anchors {
            top: parent.top
          }
          color: "transparent"

          Text {
            anchors {
              verticalCenter: parent.verticalCenter
              left: parent.left
              leftMargin: 20
            }

            text: qsTr("Large")
            color: "white"
            font.pixelSize: 40
          }

          MouseArea {
            anchors.fill: parent

            onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
            onReleased: parent.color = "transparent"

            onClicked: {
              SystemInterface.size = 0
              selectPannelInnerRect.onSizeSelect()
            }
          }
        }

        Rectangle {
          width: parent.width * .9
          height: 1
          color: "white"
          anchors {
            top: largeSizeBtnRect.bottom
            horizontalCenter: parent.horizontalCenter
          }
        }

        Rectangle {
          id: mediumSizeBtnRect
          height: parent.height / 3
          width: parent.width
          anchors {
            top: largeSizeBtnRect.bottom
          }
          color: "transparent"

          Text {
            anchors {
              verticalCenter: parent.verticalCenter
              left: parent.left
              leftMargin: 20
            }

            text: qsTr("Medium")
            color: "white"
            font.pixelSize: 40
          }

          MouseArea {
            anchors.fill: parent

            onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
            onReleased: parent.color = "transparent"

            onClicked: {
              SystemInterface.size = 1
              selectPannelInnerRect.onSizeSelect()
            }
          }
        }

        Rectangle {
          width: parent.width * .9
          height: 1
          color: "white"
          anchors {
            top: mediumSizeBtnRect.bottom
            horizontalCenter: parent.horizontalCenter
          }
        }

        Rectangle {
          id: smallSizeBtnRect
          height: parent.height / 3
          width: parent.width
          anchors {
            top: mediumSizeBtnRect.bottom
          }
          color: "transparent"

          Text {
            anchors {
              verticalCenter: parent.verticalCenter
              left: parent.left
              leftMargin: 20
            }

            text: qsTr("Small")
            color: "white"
            font.pixelSize: 40
          }

          MouseArea {
            anchors.fill: parent

            onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
            onReleased: parent.color = "transparent"

            onClicked: {
              SystemInterface.size = 2
              selectPannelInnerRect.onSizeSelect()
            }
          }
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

      onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
      onReleased: parent.color = "transparent"

      onClicked: {
        if (SystemInterface.currentDrinkType === 0) {
          SystemInterface.currentPage = "ui/HotDrinkSelectScreen.qml"
        } else {
          SystemInterface.currentPage = "ui/CoolDrinkSelectScreen.qml"
        }
      }
    }
  }
}

import QtQuick
import QtQuick.Layouts

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
    id: sugarLevelSelectContainer

    height: parent.height
    width: parent.width * 0.5
    anchors {
      right: parent.right
    }
    color: "transparent"

    // Text {
    //     id: testText
    //     text: qsTr("Hello\nWorld")
    //     anchors.centerIn: parent
    //     font.pixelSize: 25

    //     color: "#ffffff"
    // }
    Rectangle {
      anchors {
        top: parent.top
        right: parent.right
        left: parent.left
        bottom: parent.bottom
        topMargin: 40
        bottomMargin: 20
        leftMargin: 20
        rightMargin: 20
      }

      radius: 15
      color: "transparent"

      ListModel {
        id: sugarLevelListModel

        ListElement {
          level: 6
          levelName: qsTr("More Sugar 150%")
          levelColor: "#402D1F"
        }
        ListElement {
          level: 5
          levelName: qsTr("Normal Sugar 100%")
          levelColor: "#6C4B2C"
        }
        ListElement {
          level: 4
          levelName: qsTr("Less Sugar 75%")
          levelColor: "#8C6239"
        }
        ListElement {
          level: 3
          levelName: qsTr("Half Sugar 50%")
          levelColor: "#A67C53"
        }
        ListElement {
          level: 2
          levelName: qsTr("Quarter Sugar 25%")
          levelColor: "#C69C6C"
        }
        ListElement {
          level: 1
          levelName: qsTr("No Sugar 0%")
          levelColor: "#C9B099"
        }
      }

      ListView {
        id: sugarLevelGridView
        anchors.fill: parent
        model: sugarLevelListModel

        delegate: Rectangle {
          width: parent.width
          height: parent.height / 6

          color: "transparent"

          Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            radius: 15
            color: model.levelColor

            Text {
              color: "white"
              text: model.levelName
              anchors.centerIn: parent
              font.pixelSize: 24
            }

            MouseArea {
              anchors.fill: parent
              onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
              onReleased: parent.color = model.levelColor
              onClicked: {
                SystemInterface.sugarLevel = model.level
                SystemInterface.sugarLevelText = model.levelName
                SystemInterface.currentPage = "ui/ConfirmationScreen.qml"
              }
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

      onClicked: {
        SystemInterface.sugarLevelText = "_"
        SystemInterface.currentPage = "ui/SizeSelectScreen.qml"
      }
    }
  }
}

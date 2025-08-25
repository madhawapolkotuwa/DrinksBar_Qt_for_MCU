import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: drinkSelectScreen
  color: "transparent"

  CoolDrinksModel {
    id: coolDrinkModel
  }

  Component {
    id: drinkItemDelegate

    Rectangle {
      color: "transparent"
      //Layout.fillWidth: true
      //Layout.fillHeight: true
      width: 150
      height: 120 + 50

      radius: 10

      Image {
        id: drinkItemImg
        source: "file://" + model.image
        fillMode: Image.PreserveAspectFit
        anchors {
          top: parent.top
          topMargin: 5
          horizontalCenter: parent.horizontalCenter
        }
      }

      Text {
        id: drinkItemNameTxt
        text: model.name
        color: "white"
        font: Qt.font({
                        "unicodeCoverage": [Font.UnicodeBlock_BasicLatin] // << define character set
                      })
        anchors {
          top: drinkItemImg.bottom
          topMargin: 5
          horizontalCenter: drinkItemImg.horizontalCenter
        }
      }

      MouseArea {
        anchors.fill: parent

        onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
        onReleased: parent.color = "transparent"

        onClicked: {
          SystemInterface.selectedDrinkName = model.name
          SystemInterface.selectedDrinkImage = model.image
          SystemInterface.selectedDrinkGlassImage = model.glassImage

          if (SystemInterface.selectedDrinkName === "Fresh Juice") {
            SystemInterface.currentDrinkType = 2
            SystemInterface.currentPage = "ui/FreshJuiceSelectScreen.qml"
          } else {
            SystemInterface.currentPage = "ui/SizeSelectScreen.qml"
          }
        }
      }
    }
  }

  GridLayout {
    anchors {
      left: parent.left

      right: parent.right
      top: parent.top
      bottom: parent.bottom
      topMargin: 50
      leftMargin: 20
      bottomMargin: 60
    }

    rows: 2
    columns: 4
    rowSpacing: 5
    columnSpacing: 5

    Repeater {
      id: drinkRepeter
      model: coolDrinkModel
      delegate: drinkItemDelegate
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

    radius: 10

    color: "transparent"

    Image {
      id: backBtnImge
      source: "file://034.png"
      anchors {
        left: parent.left
        leftMargin: 5
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
        SystemInterface.currentPage = "ui/HotCoolSelectScreen.qml"
      }
    }
  }
}

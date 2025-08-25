import QtQuick

Rectangle {
  id: hotCollSelectScreen
  color: "transparent"

  Rectangle {
    id: hotBtnRect
    anchors {
      left: parent.left
      top: parent.top
      topMargin: 90
      leftMargin: 20
      bottom: parent.bottom
      bottomMargin: 65
    }
    radius: 30

    width: parent.width * 0.5  - 20
    color: "transparent"


    Image {
      id: hotBtnImg
      source: "file://001.png"
      anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
      }
    }

    Text {
      id: hotBtnText
      anchors {
        top: hotBtnImg.bottom
        left: hotBtnImg.left
        leftMargin: 35
      }

      text: qsTr("HOT")
      color: "#EC593B"

      font.pixelSize: 60
    }

    MouseArea {
      anchors.fill: parent

      onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
      onReleased: parent.color = "transparent"

      onClicked: {
        SystemInterface.currentDrinkType = 0
        SystemInterface.currentPage = "ui/HotDrinkSelectScreen.qml"
      }
    }
  }

  Rectangle {
    id: coolBtnRect
    anchors {
      right: parent.right
      top: parent.top
      topMargin: 90
      rightMargin: 20
      bottom: parent.bottom
      bottomMargin: 65
    }

    radius: 30
    width: parent.width * 0.5 - 20
    color: "transparent"

    Image {
      id: coolBtnImg
      source: "file://002.png"
      anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
      }
    }

    Text {
      id: coolBtnText
      anchors {
        top: coolBtnImg.bottom
        left: coolBtnImg.left
        leftMargin: 40
      }

      text: qsTr("COOL")
      color: "#428DFF"
      font.pixelSize: 60
    }

    MouseArea {
      anchors.fill: parent

      onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
      onReleased: parent.color = "transparent"

      onClicked: {
        SystemInterface.currentDrinkType = 1
        SystemInterface.currentPage = "ui/CoolDrinkSelectScreen.qml"
      }
    }
  }

  Rectangle {
    id: languageBar

    height: 60
    width: 150
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
    }

    color: "transparent"

    Row {
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      spacing: 20

      Image {
        source: "assets/uk.png"
        width: 60
        height: 50

        MouseArea {
          anchors.fill: parent
          onClicked: {
            Qt.uiLanguage = ""
          }
        }
      }

      Image {
        source: "assets/jpn.png"
        width: 60
        height: 50

        MouseArea {
          anchors.fill: parent
          onClicked: {
            Qt.uiLanguage = "ja_JP"
          }
        }
      }

    }
  }
}

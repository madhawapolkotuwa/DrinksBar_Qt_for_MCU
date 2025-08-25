import QtQuick
import DrinkBarConfiguration
import "ui"

Rectangle {
  id: root
  width: 800
  height: 480
  color: "#1A1A1A"

  TopBar {
    anchors {
      top: parent.top
      topMargin: 5
    }

    width: parent.width
  }

  Rectangle {
    anchors {
      top: parent.top
      right: parent.right
    }
    width: 50
    height: 50
    color: "transparent"

    Image {
      source: "file://048.png"
      anchors.centerIn: parent
    }

    MouseArea {
      anchors.fill: parent

      onClicked: {
        settingsDialog.triggerAnimation()
      }
    }
  }

  Loader {
    id: pageLoader
    anchors.fill: parent
    source: SystemInterface.currentPage
  }

  SettingsDialog {
    id: settingsDialog
    visible: false
    opacity: Configuration.enableFadingAnimations ? 0 : 1
    anchors.fill: parent
    z: 11
  }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import DrinkBarConfiguration

Rectangle {
  id: settingsDialog
  color: "#88000000"
  visible: true

  opacity: Configuration.enableFadingAnimations ? 0 : 1

  signal triggerAnimation
  signal stopAnimation

  Behavior on opacity {
    NumberAnimation {}
  }

  SequentialAnimation {
    id: showAnimation
    alwaysRunToEnd: true
    ScriptAction {
      script: settingsDialog.visible = true
    }
    PropertyAnimation {
      target: settingsDialog
      property: "opacity"
      from: 0.0
      to: 1.0
    }
  }

  SequentialAnimation {
    id: hideAnimation
    alwaysRunToEnd: true
    PropertyAnimation {
      target: settingsDialog
      property: "opacity"
      from: 1.0
      to: 0.0
    }
    ScriptAction {
      script: settingsDialog.visible = false
    }
  }

  Connections {
    target: settingsDialog

    onTriggerAnimation: {
      if (Configuration.enableFadingAnimations) {
        showAnimation.running = true
      } else {
        settingsDialog.visible = true
      }
    }

    onStopAnimation: {
      if (Configuration.enableFadingAnimations) {
        hideAnimation.running = true
      } else {
        settingsDialog.visible = false
      }
    }
  }

  MouseArea {
    anchors.fill: parent
  }

  Rectangle {

    width: 500
    height: 360

    anchors.centerIn: parent

    color: "#0C0421"

    Rectangle {
      height: 50
      width: 50

      radius: 25

      anchors {
        top: parent.top
        right: parent.right
      }

      color: "red"

      Text {
        id: closeText
        text: qsTr("X")
        anchors.centerIn: parent
        font.pixelSize: 20
        color: "white"
      }

      MouseArea {
        anchors.fill: parent

        onClicked: {
          settingsDialog.stopAnimation()
        }
      }
    }

    Item {
      anchors.fill: parent

      Rectangle {
        id: dateSettingsLableContainer
        anchors {
          top: parent.top
          topMargin: 50
        }

        width: parent.width
        height: 30
        color: "#00000000"
        Row {
          anchors.fill: parent

          Item {
            width: parent.width / 3
            Text {
              id: yearLable
              text: qsTr("Year")
              color: "#ffffff"
              font.pixelSize: 25
              anchors.centerIn: parent
            }
          }

          Item {
            width: parent.width / 3
            Text {
              id: monthLable
              text: qsTr("Month")
              color: "#ffffff"
              font.pixelSize: 25
              anchors.centerIn: parent
            }
          }

          Item {
            width: parent.width / 3
            Text {
              id: dateLable
              text: qsTr("Date")
              color: "#ffffff"
              font.pixelSize: 25
              anchors.centerIn: parent
            }
          }
        }
      }

      Rectangle {
        id: dateSettingsContainer
        width: parent.width
        height: 80
        anchors {
          top: dateSettingsLableContainer.bottom
        }

        color: "#00000000"
        Row {
          anchors.fill: parent

          ListView {
            id: yearView
            width: parent.width / 3
            height: parent.height
            clip: true
            model: 30

            delegate: Text {
              width: yearView.width
              height: 30
              text: 2020 + index
              horizontalAlignment: Text.AlignHCenter
              font.pixelSize: 25
              color: yearView.currentIndex === index ? "#ffffff" : "#737170"
              MouseArea {
                anchors.fill: parent
                onClicked: yearView.currentIndex = index
              }
            }
            onContentYChanged: {
              var itemHeight = 30
              var index = Math.round(contentY / itemHeight)
              currentIndex = Math.max(0, Math.min(index, 29))
              contentY = currentIndex * itemHeight
            }
          }

          ListView {
            id: monthView
            width: parent.width / 3
            height: parent.height
            clip: true
            model: 12

            delegate: Text {
              width: monthView.width
              height: 30
              text: index + 1
              horizontalAlignment: Text.AlignHCenter
              font.pixelSize: 25
              color: monthView.currentIndex === index ? "#ffffff" : "#737170"
              MouseArea {
                anchors.fill: parent
                onClicked: monthView.currentIndex = index
              }
            }
            onContentYChanged: {
              var itemHeight = 30
              var index = Math.round(contentY / itemHeight)
              currentIndex = Math.max(0, Math.min(index, 11))
              contentY = currentIndex * itemHeight
            }
          }

          ListView {
            id: dateView
            width: parent.width / 3
            height: parent.height
            clip: true
            model: 31

            delegate: Text {
              width: dateView.width
              height: 30
              text: index + 1
              horizontalAlignment: Text.AlignHCenter
              font.pixelSize: 25
              color: dateView.currentIndex === index ? "#ffffff" : "#737170"
              MouseArea {
                anchors.fill: parent
                onClicked: dateView.currentIndex = index
              }
            }
            onContentYChanged: {
              var itemHeight = 30
              var index = Math.round(contentY / itemHeight)
              currentIndex = Math.max(0, Math.min(index, 30))
              contentY = currentIndex * itemHeight
            }
          }
        }
      }

      Rectangle {
        id: timeSettingsLableContainer
        anchors {
          top: dateSettingsContainer.bottom
          topMargin: 40
        }

        width: parent.width
        height: 30
        color: "#00000000"
        Row {
          anchors.fill: parent

          Item {
            width: parent.width / 3
            Text {
              id: hoursLable
              text: qsTr("Hours")
              color: "#ffffff"
              font.pixelSize: 25
              anchors.centerIn: parent
            }
          }

          Item {
            width: parent.width / 3
            Text {
              id: minutesLable
              text: qsTr("Minutes")
              color: "#ffffff"
              font.pixelSize: 25
              anchors.centerIn: parent
            }
          }
        }
      }

      Rectangle {
        id: timeSettingsContainer
        width: parent.width
        height: 80
        anchors {
          top: timeSettingsLableContainer.bottom
        }

        color: "#00000000"
        Row {
          anchors.fill: parent

          ListView {
            id: hoursView
            width: parent.width / 3
            height: parent.height
            clip: true
            model: 24
            currentIndex: DateTimeProvider.hours - 1
            delegate: Text {
              width: hoursView.width
              height: 30
              text: index + 1
              horizontalAlignment: Text.AlignHCenter
              font.pixelSize: 25
              color: hoursView.currentIndex === index ? "#ffffff" : "#737170"
              MouseArea {
                anchors.fill: parent
                onClicked: hoursView.currentIndex = index
              }
            }
            onContentYChanged: {
              var itemHeight = 30
              var index = Math.round(contentY / itemHeight)
              currentIndex = Math.max(0, Math.min(index, 23))
              contentY = currentIndex * itemHeight
            }
          }

          ListView {
            id: minutesView
            width: parent.width / 3
            height: parent.height
            clip: true
            model: 60
            delegate: Text {
              width: minutesView.width
              height: 30
              text: index + 1
              horizontalAlignment: Text.AlignHCenter
              font.pixelSize: 25
              color: minutesView.currentIndex === index ? "#ffffff" : "#737170"
              MouseArea {
                anchors.fill: parent
                onClicked: minutesView.currentIndex = index
              }
            }
            onContentYChanged: {
              var itemHeight = 30
              var index = Math.round(contentY / itemHeight)
              currentIndex = Math.max(0, Math.min(index, 59))
              contentY = currentIndex * itemHeight
            }
          }
        }
      }
    }

    Rectangle {
      id: setButton
      anchors {
        bottom: parent.bottom
        right: parent.right
        bottomMargin: 5
        rightMargin: 5
      }

      width: 100
      height: 60

      radius: 10
      color: "#398F0B"

      Text {
        anchors.centerIn: parent
        text: qsTr("Set")
        font.pixelSize: 30
        color: "#ffffff"
      }

      MouseArea {
        anchors.fill: parent

        onPressed: parent.color = Qt.rgba(210, 210, 210, 0.5)
        onReleased: parent.color = "#398F0B"

        onClicked: {
          DateTimeProvider.year = yearView.currentIndex + 20
          DateTimeProvider.month = monthView.currentIndex + 1
          DateTimeProvider.date = dateView.currentIndex + 1

          DateTimeProvider.hours = hoursView.currentIndex + 1
          DateTimeProvider.minutes = minutesView.currentIndex + 1

          DateTimeProvider.setTimeAndDate()

          settingsDialog.stopAnimation()
        }
      }
    }
  }
}

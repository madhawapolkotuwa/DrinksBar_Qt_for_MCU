import QtQuick
import QtQuick.Shapes

Rectangle {
  id: preparationDrinkScreen
  color: "transparent"

  Component.onCompleted: {
    SystemInterface.startPreparing()
  }

  Rectangle {
    id: preparingDrinkBusyIndicator
    width: 300
    height: 300

    anchors.centerIn: parent
    color: "transparent"

    Shape {
      id: spinner
      anchors.centerIn: parent
      width: 200
      height: 200

      ShapePath {
        strokeColor: "white"
        strokeWidth: 12
        fillColor: "transparent"
        capStyle: ShapePath.RoundCap
        joinStyle: ShapePath.RoundJoin

        // Define a circular arc
        startX: spinner.width / 2 + (spinner.width / 2 - 10) * Math.cos(
                  0) // Start at angle 0
        startY: spinner.height / 2 + (spinner.height / 2 - 10) * Math.sin(0)

        // Draw only a 90° arc (quarter circle)
        PathArc {
          x: spinner.width / 2 + (spinner.width / 2 - 10) * Math.cos(
               Math.PI * 0.75) // End at 90 degrees for a quarter arc
          y: spinner.height / 2 + (spinner.height / 2 - 10) * Math.sin(
               Math.PI * 0.75)
          radiusX: spinner.width / 2 - 10
          radiusY: spinner.height / 2 - 10
          useLargeArc: false
        }
      }

      // Rotate the shape continuously
      NumberAnimation on rotation {
        from: 0
        to: 360
        duration: 1000
        loops: Animation.Infinite
      }
    }
  }

  Text {
    anchors {
      top: preparingDrinkBusyIndicator.bottom
      topMargin: 10
      horizontalCenter: parent.horizontalCenter
    }

    text: qsTr("Preparing Drink...")
    color: "white"
    font.pixelSize: 32
  }

  SystemInterface.onDoneDrinkOrder: {
    SystemInterface.currentPage = "ui/EnjoyMegScreen.qml"
  }
}

import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    signal minimized(string button)
    property int lastMouseX
    property int lastMouseY
    id: rectangle
    width: 400
    height: 45

    Rectangle {
        width: 112
        height: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        Rectangle {
            id: close
            x: 56
            y: 0
            width: 56
            height: 45
            color: "#ffffff"

            Image {
                x: 18
                y: 13
                width: 20
                height: 20
                source: "../images/x.png"
                sourceSize.height: 20
                sourceSize.width: 20
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                id: closeButton
                x: 0
                y: 0
                width: 56
                height: 45
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: close.color= "#FF5770"
                onExited: close.color= "#ffffff"

                Connections {
                    target: closeButton
                    onClicked: Qt.quit()
                }
            }
        }

        Rectangle {
            id: minimize
            color: "#ffffff"
            width: 56
            height: 45
            Image {
                x: 16
                y: 19
                width: 25
                height: 10
                source: "../images/-.png"
                sourceSize.width: 25
                sourceSize.height: 10
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                id: minimizeButton
                x: 0
                y: 1
                width: 56
                height: 45
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: minimize.color= "#f6f6f6"
                onExited: minimize.color= "#ffffff"

                Connections {
                    target: minimizeButton
                    onClicked: minimized("min")
                }
            }
        }


    }

    Rectangle {
        color: "#ffffff"
        width: parent.width - 112
        height: 45
        Image {
            x: 9
            y: 11
            width: 20
            height: 20
            source: "../images/Capgemini_Spade_2Colors_RGB.png"
            sourceSize.height: 20
            sourceSize.width: 20
            fillMode: Image.PreserveAspectFit
        }

        Text {
            x: 37
            y: 12
            text: "CapFomations"
            font.pointSize: 12
            font.family: "Ubuntu Light"
        }


        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag.target: mainWindow
            width: 100
            height: 100
            onPressed: {
                lastMouseX = mouse.x;
                lastMouseY = mouse.y;
            }

            onPositionChanged: {
                // Calculate the movement of the mouse
                var deltaX = mouse.x - lastMouseX;
                var deltaY = mouse.y - lastMouseY;

                // Move the window accordingly
                mainWindow.x += deltaX;
                mainWindow.y += deltaY;

                // Update the last mouse position
                lastMouseX = mouse.x;
                lastMouseY = mouse.y;
            }
        }
    }
}

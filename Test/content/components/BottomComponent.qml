import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components

Rectangle {
    signal buttonClicked(string button)
    id: rectangle4
    width: 1150
    height: 72
    color: "#ffffff"
    property bool adminPrev: false

    Rectangle {
        id: addRectangle
        x: 975
        y: 16
        width: 108
        height: 40
        visible: rectangle4.adminPrev
        radius: 5
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.0
                color: "#0070AD"
            }
            GradientStop {
                position: 1.5
                color: "#12ABDB"
            }
        }

        Text {
            id: addText
            x: 19
            y: 9
            color: "#ffffff"
            text: qsTr("Ajouter")
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            font.family: "Ubuntu Medium"
        }

        MouseArea {
            id: add
            visible: true
            anchors.fill: parent
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            cursorShape: Qt.PointingHandCursor

            Connections {
                target: add
                onClicked: buttonClicked("ajouter");
            }
        }
    }
    BorderItem {
        id: border3
        radius: 0
        anchors.fill: parent
        strokeColor: "#e5e4e2"
        strokeWidth: 1
        drawBottom: false
        drawRight: false
        drawLeft: false
        drawTop: true
        adjustBorderRadius: true
    }
}

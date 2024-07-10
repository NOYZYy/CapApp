import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components

Rectangle {
    property string rootTitle: ""
    signal backTo()
    id: rectangle
    x: 0
    y: 0
    width: 1150
    height: 64
    color: "#ffffff"

    Image {
        id: image
        x: 998
        y: 0
        width: 152
        height: 64
        source: "../images/Capgemini_Logo_Color_RGB.png"
        sourceSize.height: 50
        sourceSize.width: 200
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image1
        x: 52
        y: 19
        width: 31
        height: 26
        source: "../images/Capgemini_Spade_2Colors_RGB.png"
        sourceSize.height: 30
        sourceSize.width: 30
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: title
        x: 87
        y: 21
        text: rectangle.rootTitle
        font.pixelSize: 20
        font.family: "Ubuntu Medium"
    }

    BorderItem {
        id: border1
        x: 0
        y: 0
        width: 1150
        height: 64
        radius: 0
        strokeWidth: 1
        drawLeft: false
        drawTop: false
        drawBottom: true
        drawRight: false
        bevel: false
        strokeColor: "#e5e4e2"
        bottomLeftBevel: false
        bottomLeftRadius: 0
        bottomRightRadius: 0
        topRightRadius: 0
        topLeftRadius: 0
        adjustBorderRadius: true
    }

    Rectangle {
        id: backRec
        x: 0
        y: 0
        width: 46
        height: 63
        color: "#ffffff"

        MouseArea {
            id: back
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: backRec.color= "#f6f6f6";
            onExited: backRec.color= "#ffffff";
            Connections {

            }

            Connections {
                target: back
                onClicked: backTo();
            }
        }

        Image {
            x: 8
            y: 17
            width: 30
            height: 30
            source: "../images/back.png"
            sourceSize.height: 30
            sourceSize.width: 30
            fillMode: Image.PreserveAspectFit
        }
    }
}

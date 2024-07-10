import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components

Rectangle {
    signal buttonClicked(string button)
    property string msgErrorText: ""
    property string title : "Suppression"
    id: dialogBox
    width: 428
    height: 173
    color: "#f6f6f6"
    radius: 5
    layer.enabled: true

    Rectangle {
        x: 0
        y: 0
        width: 428
        height: 36
        color: "#ffffff"
        radius: 5

        Image {
            x: 8
            y: 4
            width: 25
            height: 28
            source: "../images/Capgemini_Spade_2Colors_RGB.png"
            sourceSize.height: 36
            sourceSize.width: 36
            fillMode: Image.PreserveAspectFit
        }

        Text {
            x: 39
            y: 10
            text: title
            font.pixelSize: 16
            font.family: "Ubuntu Medium"
        }

        Rectangle {
            id: closeRec
            x: 389
            y: 0
            width: 39
            height: 36
            color: "#ffffff"
            radius: 5


            MouseArea {
                id: close
                x: 0
                y: 0
                width: 39
                height: 36
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: closeRec.color= "#FF5770";
                onExited: closeRec.color= "#ffffff";

                Connections {
                    id: connections
                    target: close
                    onClicked: buttonClicked("close")
                }

            }
            Image {
                x: 11
                y: 9
                width: 18
                height: 18
                source: "../images/x.png"
                sourceSize.height: 18
                sourceSize.width: 18
                fillMode: Image.PreserveAspectFit
            }
        }

        BorderItem {
            x: 0
            y: 0
            radius: 0
            anchors.fill: parent
            drawRight: false
            drawLeft: false
            drawTop: false
            strokeWidth: 1
            strokeColor: "#e5e4e2"
        }
    }

    Text {
        id: msgText
        x: 133
        y: 42
        width: 254
        height: 58
        text: msgErrorText
        font.pixelSize: 14
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.family: "Ubuntu Light"
        wrapMode: Text.WordWrap
    }
    Rectangle {
        id: ouiRec
        x: 89
        y: 122
        width: 75
        height: 35
        radius: 5
        border.color: "#cbcbcb"
        border.width: 1
        color: "#ffffff"

        Text {
            id: ouiText
            x: 18
            y: 6
            anchors.fill: parent
            color: "#000000"
            text: qsTr("Oui")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Ubuntu Light"
        }

        MouseArea {
            id: oui
            anchors.fill: parent
            hoverEnabled: true
            onEntered: ouiRec.color= "#FF5770";
            onExited: ouiRec.color= "#ffffff";
            Connections {
                target: oui
                onClicked: buttonClicked("oui")
            }
            cursorShape: Qt.PointingHandCursor
        }
    }

    Rectangle {
        id: nomRec
        x: 251
        y: 122
        width: 75
        height: 35
        color: "#ffffff"
        radius: 5
        border.color: "#cbcbcb"
        border.width: 1
        Text {
            id: nomText
            x: 18
            y: 6
            color: "#000000"
            text: qsTr("Non")
            anchors.fill: parent
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Ubuntu Light"
        }

        MouseArea {
            id: nom
            anchors.fill: parent
            onExited: nomRec.color= "#ffffff"
            onEntered: nomRec.color= "#57CF80"
            hoverEnabled: true
            Connections {
                target: nom
                onClicked: buttonClicked("nom")
            }
            cursorShape: Qt.PointingHandCursor
        }
    }

    Image {
        id: image
        x: 47
        y: 47
        width: 53
        height: 53
        source: "../images/interogation.png"
        sourceSize.height: 53
        sourceSize.width: 53
        fillMode: Image.PreserveAspectFit
    }
}


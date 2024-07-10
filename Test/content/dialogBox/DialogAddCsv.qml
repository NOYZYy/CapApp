import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components

Rectangle {
    signal buttonClicked(string button)
    property string msgErrorText: "Choisissez un fichier csv"
    property string title : "Suppression"
    property bool addEnabled: false
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
            text: "Ajout "
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
                onClicked: buttonClicked("close")

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
        x: 139
        y: 62
        height: 33
        color: "#12abdb"
        text: msgErrorText
        font.pixelSize: 14
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.family: "Ubuntu Light"
        wrapMode: Text.WordWrap

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onExited: msgText.color= "#12abdb"
            onEntered: msgText.color= "#0070AD"
            onClicked: buttonClicked("choisir")
        }
    }

    Rectangle {
        id: nomRec
        x: 177
        y: 121
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
            text: qsTr("Ajouter")
            anchors.fill: parent
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Ubuntu Light"
        }

        MouseArea {
            id: nom
            anchors.fill: parent
            enabled: addEnabled
            onExited: nomRec.color= "#ffffff"
            onEntered: nomRec.color= "#57CF80"
            onEnabledChanged: {
                if(nom.enabled){
                    cursorShape= Qt.PointingHandCursor
                }
                else{
                    cursorShape= Qt.ArrowCursor
                }
            }
            hoverEnabled: true
            onClicked: buttonClicked("ajouter")
            cursorShape: Qt.PointingHandCursor
        }
    }

    Image {
        id: image
        x: 42
        y: 52
        width: 53
        height: 53
        source: "../images/csv.png"
        sourceSize.height: 53
        sourceSize.width: 53
        fillMode: Image.PreserveAspectFit
    }
}

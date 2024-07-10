import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components

Rectangle {
    signal buttonClicked(string button,string perimetreName,string perimetreDescription)
    id: dialogBoxModify
    width: 428
    height: 292
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
            text: qsTr("Ajout ")
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
                    target: close
                    onClicked: buttonClicked("close","","")
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
        x: 41
        y: 42
        text: qsTr("Nom :")
        font.pixelSize: 14
        font.family: "Ubuntu Medium"
    }

    TextField {
        id: perimetreName
        x: 41
        y: 64
        width: 346
        height: 38
        placeholderText: qsTr("Nom ")
        maximumLength: 20
        font.pointSize: 10
        hoverEnabled: true
        selectionColor: "#5b90df"
        font.family: "Ubuntu Light"
        background:
            Rectangle{
            id: perimetreNameRec
            radius: 3
            border.color: "#afafaf"
            border.width: 1
            anchors.fill: parent
        }

        Connections {
            target: perimetreName
            onPressed: perimetreNameRec.border.color= "#5b90df";
        }

        Connections {
            target: perimetreName
            onEditingFinished: perimetreNameRec.border.color= "#afafaf"
        }
    }

    Text {
        x: 41
        y: 108
        text: qsTr("Discreption:")
        font.pixelSize: 14
        font.family: "Ubuntu Medium"
    }

    ScrollView {
        x: 41
        y: 130
        width: 346
        height: 95

        TextArea {
            id: perimetreDescription
            width: 346
            height: 95
            padding: 10
            font.family: "Ubuntu Light"
            font.pointSize: 10
            placeholderText: qsTr("Description")
            background: Rectangle {
                id: perimetreDescriptionRec
                color: "#ffffff"
                radius: 3
                anchors.fill: parent
                BorderItem {
                    id: perimetreDescriptionRecBorder
                    x: 0
                    y: 0
                    radius: 3
                    anchors.fill: parent
                    strokeWidth: 1
                    strokeColor: "#b2beb5"
                }
            }
        }
        Connections {
            target: perimetreDescription
            onPressed: perimetreDescriptionRecBorder.strokeColor= "#5b90df";
        }

        Connections {
            target: perimetreDescription
            onEditingFinished: perimetreDescriptionRecBorder.strokeColor= "#b2beb5"
        }
    }

    Text {
        id: msgError
        x: 46
        y: 230
        visible: msgError.msgErrorEnabled
        color: "#ff304d"
        text: qsTr("Les deux champs sont obligatoires")
        font.pixelSize: 12
        property bool msgErrorEnabled: false
        font.family: "Ubuntu Light"
    }

    Rectangle {
        id: modifyRec
        x: 177
        y: 249
        width: 75
        height: 35
        radius: 5
        border.color: "#cbcbcb"
        border.width: 1
        color: "#ffffff"

        Text {
            id: modifyText
            x: 18
            y: 6
            anchors.fill: parent
            color: "#000000"
            text: qsTr("Ajouter")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Ubuntu Light"
        }

        MouseArea {
            id: modify
            anchors.fill: parent
            hoverEnabled: true
            onEntered: modifyRec.color= "#57CF80";
            onExited: modifyRec.color= "#ffffff";
            Connections {
                target: modify
                onClicked: {
                    perimetreName.focus= false;perimetreDescription.focus= false;
                    if(perimetreDescription.text==="" || perimetreDescription.text===""){
                        msgError.msgErrorEnabled= true;
                        if(perimetreName.text=== ""){
                            perimetreNameRec.color="#ffd6dc";
                            perimetreNameRec.border.color= "#E30021"
                            timerError.start();
                        }
                        if(perimetreDescription.text=== ""){
                            perimetreDescriptionRec.color="#ffd6dc";
                            perimetreDescriptionRecBorder.strokeColor= "#E30021";
                            timerError.start();
                        }
                    }
                    else{
                        buttonClicked("ajouter",perimetreName.text,perimetreDescription.text);
                        perimetreName.text= ""; perimetreDescription.text= "";
                    }
                }
            }
            cursorShape: Qt.PointingHandCursor
        }
    }

    Timer {
        id: timerError
        interval: 2000
        repeat: false
        onTriggered: {
            msgError.msgErrorEnabled= false;
            perimetreNameRec.color="#ffffff";
            perimetreNameRec.border.color= "#b2beb5"
            perimetreDescriptionRec.color="#ffffff";
            perimetreDescriptionRecBorder.strokeColor= "#b2beb5";
        }
    }

}


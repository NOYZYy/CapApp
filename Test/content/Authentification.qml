import QtQuick 6.5
import QtQuick.Controls 6.5
import "components"
Item {
    FontLoader{
        source: "fonts/Ubuntu-Medium.ttf"
    }
    FontLoader{
        source: "fonts/Ubuntu-Light.ttf"
    }
    property bool enterPressed: false
    signal buttonClicked(string button)
    width: 400
    height: 545
    onEnterPressedChanged: click();

    WindowHints {
        id: windowHints
        width: 400
        onMinimized: mainWindow.showMinimized()
    }

    Rectangle {
        y:45
        id: rectangle
        width: 400
        height: 500
        color: "#ffffff"

        Image {
            id: image
            x: 0
            y: 44
            width: 400
            height: 456
            source: "images/Shape 1_Vibrant blue.png"
            sourceSize.height: 400
            sourceSize.width: 1120
            enabled: true
            fillMode: Image.Pad

            Image {
                id: image1
                x: 0
                y: 0
                width: 400
                height: 121
                source: "images/Capgemini_Logo_Color_RGB.png"
                sourceSize.height: 100
                sourceSize.width: 500
                fillMode: Image.Pad
            }
        }


        Text {
            id: text1
            x: 100
            y: 174
            color: "#000000"
            text: qsTr("Nom d'Utilisateur:")
            font.pixelSize: 14
            font.family: "Ubuntu Medium"
        }

        TextField {
            id: username
            x: 100
            y: 196
            width: 200
            height: 40
            maximumLength: 20
            font.pointSize: 10
            hoverEnabled: true
            selectionColor: "#5b90df"
            font.family: "Ubuntu Light"
            placeholderText: qsTr("Utilisateur")
            background:
                Rectangle{
                id: usernameRec
                radius: 3
                border.color: "#afafaf"
                border.width: 2
                anchors.fill: parent
            }

            Connections {
                target: username
                onPressed: usernameRec.border.color= "#5b90df";
            }

            Connections {
                target: username
                onEditingFinished: usernameRec.border.color= "#afafaf"
            }
        }

        Text {
            id: msgErrorUsername
            x: 105
            y: 239
            visible: msgErrorUsername.msgErrorUsernameEnabled
            color: "#ff304d"
            text: qsTr("ce champs est obligatoire")
            font.pixelSize: 12
            property bool msgErrorUsernameEnabled: false
            font.family: "Ubuntu Light"
        }

        Text {
            id: text2
            x: 100
            y: 258
            color: "#000000"
            text: qsTr("Mot de Passe:")
            font.pixelSize: 14
            font.family: "Ubuntu Medium"
        }

        TextField {
            id: password
            x: 100
            y: 280
            width: 200
            height: 40
            text: ""
            maximumLength: 20
            echoMode: TextInput.Password
            hoverEnabled: false
            selectionColor: "#5b90df"
            font.styleName: "Regular"
            font.pointSize: 10
            font.family: "Ubuntu Light"
            placeholderText: qsTr("Mot de passe")
            background:
                Rectangle{
                id: passwordRec
                radius: 3
                border.color: "#afafaf"
                border.width: 2
                anchors.fill: parent
            }
            Connections {
                target: password
                onPressed: passwordRec.border.color= "#5b90df";
            }

            Connections {
                target: password
                onEditingFinished: passwordRec.border.color= "#afafaf"
            }
        }

        Text {
            id: msgErrorPassword
            x: 105
            y: 323
            visible: msgErrorPassword.msgErrorPasswordEnabled
            color: "#ff304d"
            text: qsTr("ce champs est obligatoire")
            font.pixelSize: 12
            property bool msgErrorPasswordEnabled: false
            font.family: "Ubuntu Light"
        }

        Rectangle {
            id: entrerRec
            x: 152
            y: 351
            width: 97
            height: 40
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
                id: entrerText
                color: "#ffffff"
                text: qsTr("Entrer")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Ubuntu Medium"
                anchors.fill: parent
            }
            MouseArea {
                id: entrer
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                Connections {
                    id: connections
                    target: entrer
                    onClicked: {
                        click();
                    }
                }
            }
        }

        Rectangle {
            id: formationsRec
            x: 121
            y: 431
            width: 158
            height: 40
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
                id: formationsText
                color: "#ffffff"
                text: qsTr("Les Formations")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Ubuntu Medium"
                anchors.fill: parent
            }
            MouseArea {
                id: formations
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                Connections {
                    target: formations
                    onClicked:  buttonClicked("Button2");
                }

                Connections {
                    target: formations
                    onClicked: {
                        buttonClicked("formations")
                    }
                }
            }
        }

        StateGroup {
            id: stateGroup
        }

        Timer {
            id: timerError
            interval: 2000
            repeat: false
            onTriggered: {
                msgErrorUsername.msgErrorUsernameEnabled= false;
                msgErrorPassword.msgErrorPasswordEnabled= false;
                msgErrorPassword.text= "ce champs est obligatoire"
                passwordRec.border.color= "#afafaf";
                usernameRec.border.color= "#afafaf";
                usernameRec.color= "#ffffff";
                passwordRec.color="#ffffff";
            }
        }
    }
    function click(){
        username.focus= false;password.focus= false;
        if(username.text==="" || password.text===""){
            if(username.text=== ""){
                msgErrorUsername.msgErrorUsernameEnabled= true;
                usernameRec.color="#ffd6dc";
                usernameRec.border.color= "#E30021"
                timerError.start();
            }
            if(password.text=== ""){
                msgErrorPassword.msgErrorPasswordEnabled= true;
                passwordRec.border.color= "#E30021";
                passwordRec.color= "#ffd6dc";
                timerError.start();
            }
        }
        else{
            if(username.text==="AdminCap" && password.text==="Hamza117"){
                buttonClicked("entrer");
            }
            else{
                msgErrorPassword.text= "Utilisateur ou Mot de passe incorrect";
                msgErrorPassword.msgErrorPasswordEnabled= true;
                timerError.start();
            }
        }
    }
}

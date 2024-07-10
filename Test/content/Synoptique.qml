import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components
import QtQuick.Studio.Effects
import "components"
import "dialogBox"

Item {
    id: root
    property bool adminPrev: false
    signal sendDataToDetails(string index,string perimetre,string system,string name,string description)
    property bool imageExist: false
    property bool fileChosen: false
    property string perimetreSave: ""
    property string systemSave: ""
    property string objectIDPer: ""
    signal backToLastPage()
    property var composants: compController.composants
    property var descriptions: compController.descriptions
    property string help: ""
    property string des: ""
    property int idii
    property variant synComp: synController.composants
    property variant synDesc: synController.descriptions
    property variant synX: synController.xs
    property variant synY: synController.ys
    width: 1150
    height: 745

    WindowHints {
        id: windowHints
        x: 0
        y: 0
        width: 1150
        height: 45
    }
    Rectangle{
        BottomComponent {
            id: bottomComponent
            x: 0
            y: 673
        }
        TopComponent {
            id: topComponent
            x: 0
            y: 45
            width: 1150
            height: 64
            rootTitle: "Synoptique"
            onBackTo: backToLastPage()
        }

        Rectangle {
            x: 0
            y: 109
            width: 276
            height: 564
            color: "#ffffff"

            Rectangle {
                id: blocker
                anchors.fill: parent
                color: "transparent"
                visible: !fileChosen
                z: 1000
            }

            Connections {
                target: synController
                onFileSelected: {
                    fileChosen = true;
                }
            }

            Text {
                id: title
                x: 28
                y: 25
                width: 143
                height: 26
                text: systemSave+" composants"
                font.pixelSize: 22
                font.family: "Ubuntu Medium"
            }

            Text {
                x: 32
                y: 62
                width: 236
                height: 475
                font.pixelSize: 14
                wrapMode: Text.WordWrap
                font.family: "Ubuntu Light"

                Column{
                    anchors.fill: parent
                    spacing: 10
                    Repeater{
                        anchors.fill: parent
                        model: ListModel{
                            id: listModel
                            Component.onCompleted: {
                                if(synComp.length > 0){
                                    for(var i = 0; i < synComp.length; ++i){
                                        listModel.append({"name": synComp[i],"description": synDesc[i]})
                                    }
                                }
                            }
                            function createListModel(name,descreption){
                                return {
                                    "name": name,
                                    "description": descreption
                                }
                            }
                        }

                        Row{
                            spacing: 10
                            Text{
                                text: index+"    "+name+" :"
                                font.family: "Ubuntu Medium"
                                font.pixelSize: 16
                                wrapMode: Text.WordWrap
                            }
                            Text{
                                text: description
                                font.family: "Ubuntu Light"
                                font.pixelSize: 16
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                }
            }

            BorderItem {
                x: 0
                y: 0
                width: 276
                height: 564
                radius: 0
                strokeWidth: 1
                drawTop: false
                drawLeft: false
                drawRight: true
                drawBottom: false
                strokeColor: "#e5e4e2"
                bottomRightRadius: 0
                topRightRadius: 0
                bottomLeftRadius: 0
                topLeftRadius: 0
                adjustBorderRadius: true
            }
        }

        Rectangle {
            x: 276
            y: 109
            width: 873
            height: 564
            color: "#f6f6f6"
            border.width: 0

            Rectangle {
                id: rectangle
                x: 64
                y: 121
                width: 746
                height: 419
                color: "#ffffff"
                radius: 5
                border.color: "#0070ad"
                border.width: 2

                Image {
                    id: image
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    anchors.topMargin: 8
                    anchors.bottomMargin: 8
                    source: {
                        if(synController.imageUrl=== ""){
                            imageExist= flase;
                            ""
                        }else{
                            imageExist= true;
                            synController.imageUrl;
                        }
                    }
                    sourceSize.width: 650
                    sourceSize.height: 450
                    fillMode: Image.PreserveAspectFit

                    Connections{
                        target: synController
                        onImageChanged: {
                            image.source= synController.imageUrl
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: (mouse)=>{
                                       if (mouse.button === Qt.RightButton) {
                                           popupOptionsList.x= mouse.x;
                                           popupOptionsList.y= mouse.y;
                                           popupOptionsList.open();
                                       }
                                   }
                        Popup{
                            id: popupOptionsList
                            width: 98
                            height: {
                                if(composants.length*35>105)
                                    105;
                                else
                                    composants.length*35;
                            }
                            focus: true
                            Rectangle {
                                id: optionsList
                                x: -12
                                y: -12
                                width: 98
                                height: {
                                    if(composants.length*35>105)
                                        105;
                                    else
                                        composants.length*35;
                                }
                                color: "#272936"
                                border.color: "#9f9f9f"
                                border.width: 1
                                visible: true
                                layer.enabled: true
                                layer.effect: DropShadowEffect {
                                    id: dropShadow1
                                    color: "#272936"
                                    spread: 0.05
                                }

                                ScrollView {
                                    id: scrollView
                                    anchors.fill: parent
                                    wheelEnabled: true
                                    contentWidth: -1
                                    Column {
                                        id: column
                                        anchors.fill: parent
                                        Repeater {
                                            id: repeater
                                            anchors.fill: parent
                                            model: ListModel {
                                                id: synListModel
                                                Component.onCompleted: {
                                                    composants= composants.filter(item => !synComp.includes(item));
                                                    descriptions= descriptions.filter(item => !synDesc.includes(item));
                                                    if(composants.length > 0){
                                                        for (var i = 0; i < composants.length; ++i) {
                                                            synListModel.append({"name": composants[i],"description": descriptions[i]});
                                                        }
                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: composant
                                                property int id: index
                                                width: 98
                                                height: 35
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true
                                                onEntered: textn.color= "#808080";
                                                onExited: textn.color= "#a9a9a9";
                                                onClicked: {
                                                    compListModel.append(compListModel.createListElement(name,description,id,popupOptionsList.x,popupOptionsList.y));
                                                }

                                                Text {
                                                    id: textn
                                                    text: name
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    font.pixelSize: 15
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    color: "#ffffff"
                                                    font.family: "Ubuntu Medium"
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Repeater{
                            id: compRepeater
                            anchors.fill: parent
                            model: ListModel{
                                id: compListModel
                                Component.onCompleted: {
                                    if(synComp.length > 0){
                                        for(var i = 0; i < synComp.length; ++i){
                                            compListModel.append({"namecomp": synComp[i],"descriptioncomp": synDesc[i],"xx": synX[i],"yy":synY[i]})
                                        }
                                    }
                                }
                                function createListElement(compName,description,id,xx,yy){
                                    composants= composants.filter(item => item !== compName);
                                    descriptions= descriptions.filter(item => item !== description);
                                    synListModel.remove(id)
                                    synController.addComposant(objectIDPer,perimetreSave,systemSave,compName,description,parseInt(xx),parseInt(yy));
                                    popupOptionsList.close();
                                    if(composants.length*35>105){
                                        optionsList.height= 105;
                                        popupOptionsList.height= 105;
                                    }
                                    else{
                                        optionsList.height= composants.length*35;
                                        popupOptionsList.height= composants.length*35;
                                    }
                                    listModel.append(listModel.createListModel(compName,description));
                                    return{
                                        "namecomp": compName,
                                        "descriptioncomp": description,
                                        "xx": xx,
                                        "yy": yy
                                    }
                                }
                            }

                            Rectangle {
                                id: compRec
                                x: xx
                                y: yy
                                property int idComp: index
                                width: 38
                                height: 38
                                color: "#214554"
                                radius: 3
                                layer.enabled: true
                                layer.effect: DropShadowEffect {
                                    id: dropShadow
                                    color: "#000000"
                                    spread: 0.05
                                }

                                Text {
                                    id: compText
                                    color: "#ffffff"
                                    text: idComp
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 17
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "Ubuntu Medium"
                                }
                                MouseArea {
                                    id: compButton
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    onEntered: {
                                        compRec.color= "#173340";
                                        mouseArea.enabled = false;
                                    }
                                    onExited: {
                                        compRec.color= "#214554";
                                        mouseArea.enabled = true;
                                    }
                                    onClicked: (mouse)=>{
                                       if (mouse.button === Qt.RightButton && adminPrev) {
                                           help= namecomp
                                           des= descriptioncomp
                                           idii= idComp
                                           popupDialogBoxRe.popupDialogBoxReEnabled= true;
                                        }else{
                                            if(mouse.button === Qt.LeftButton){
                                                sendDataToDetails(objectIDPer,perimetreSave,systemSave,namecomp,descriptioncomp)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Text {
                id: text1
                x: 64
                y: 80
                text: qsTr("L'image synoptique")
                font.pixelSize: 18
                font.family: "Ubuntu Medium"
            }

            Rectangle {
                id: addRec
                x: 644
                y: 73
                width: 75
                height: 35
                radius: 5
                visible: adminPrev
                border.color: "#cbcbcb"
                border.width: 1
                color: "#ffffff"

                Text {
                    id: addText
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
                    id: add
                    anchors.fill: parent
                    enabled: !imageExist
                    hoverEnabled: true
                    onEntered: addRec.color= "#57CF80";
                    onExited: addRec.color= "#ffffff";
                    onClicked: {
                        synController.openFileExplorer(objectIDPer,perimetreSave,systemSave)
                    }
                }
            }

            Rectangle {
                id: modifyRec
                x: 735
                y: 73
                width: 75
                height: 35
                radius: 5
                visible: adminPrev
                border.color: "#cbcbcb"
                border.width: 1
                color: "#ffffff"

                Text {
                    id: modifyText
                    x: 18
                    y: 6
                    anchors.fill: parent
                    color: "#000000"
                    text: qsTr("Modifier")
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Ubuntu Light"
                }

                MouseArea {
                    id: modify
                    enabled: imageExist
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: modifyRec.color= "#57CF80";
                    onExited: modifyRec.color= "#ffffff";
                    onClicked: {
                        if(compListModel.count > 0){
                            popupText.text= "Supprimer les liasons";
                            popupRectangle.color= "#E30021";
                            popupRectangle.opacity= 1;
                            popup.open();
                            exitTimer.start();
                        }else{
                            synController.openFileExplorer(objectIDPer,perimetreSave,systemSave)
                            popupText.text= "Modifier avec succés";
                            popupRectangle.color= "#178C3D";
                            popupRectangle.opacity= 1;
                            popup.open();
                            exitTimer.start();
                        }
                    }
                }
            }
        }
        Popup{
            id: popupDialogBoxRe
            x: 361
            y: 203
            visible: popupDialogBoxRe.popupDialogBoxReEnabled
            property bool popupDialogBoxReEnabled: false
            modal: true
            closePolicy: Popup.NoAutoClose
            background: DialogBoxRe{
                id: dialogBoxID
                msgErrorText: "Voulez vous supprimer la liason entre la synoptique et la composant " + help + " ?"
                onButtonClicked: {
                    if(button=== "oui"){
                        composants= [...composants];
                        descriptions= [...descriptions];
                        compListModel.remove(idii);
                        listModel.remove(idii);
                        synListModel.append({"name": help,"description":des});
                        composants.push(help);
                        descriptions.push(des);
                        if(composants.length*35>105){
                            optionsList.height= 105;
                            popupOptionsList.height= 105;
                        }
                        else{
                            optionsList.height= composants.length*35;
                            popupOptionsList.height= composants.length*35;
                        }
                        synController.deleteComposant(objectIDPer,perimetreSave,systemSave,help);
                        popupDialogBoxRe.popupDialogBoxReEnabled= false;
                    }
                    else{
                        popupDialogBoxRe.popupDialogBoxReEnabled= false;
                    }
                }
            }
        }
    }
    Popup{
        id: popup
        x: 5
        y: 628
        background: Rectangle{
            id: popupRectangle
            color: "#FF304D"
            radius: 5
            Text{
                id: popupText
                color: "#ffffff"
                text: "il faut remplir tous les champs"
                font.pointSize: 10
                font.family: "Ubuntu Medium"
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        width: 200
        height: 40
        Timer {
            id: exitTimer
            interval: 1000
            repeat: false
            onTriggered: {
                opacityAnimation.start();
            }
        }
        PropertyAnimation {
            id: opacityAnimation
            target: popupRectangle
            property: "opacity"
            from: 1
            to: 0
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
}

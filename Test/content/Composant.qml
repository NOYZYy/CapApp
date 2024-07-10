import QtQuick 2.15
import QtQuick.Controls 2.15
import "dialogBox"
import "components"

Item {
    signal sendDataToDetails(string index,string perimetre,string system,string name,string description)
    signal sendDataToSynoptique(string index,string perimetre,string name)
    signal sendDataToQuiz(string index,string perimetre,string name)
    signal backToLastPage()
    id: root
    width: 1150
    height: 700
    property string help: ""
    property string perimetreDescription: ""
    property string perimetreName: ""
    property bool adminPrev: false
    property string perimetreSave: ""
    property string systemSave: perimetreName
    property string objectIDPer: ""

    WindowHints {
        id: windowHints
        width: 1150
        onMinimized: mainWindow.showMinimized()
    }

    Rectangle{
        y:45
        TopComponent {
            width: 1150
            height: 64
            rootTitle: "Composants"
            onBackTo: backToLastPage()
        }

        LeftComponent{
            x: 0
            y: 64
            width: 276
            height: 564
            title: perimetreName
            description: perimetreDescription
        }

        MainComponent{
            id: mainComponent
            x: 276
            y: 64
            width: 874
            height: 564
            rootTitle: "composant"
            ids: compController.ids
            perimetres: compController.composants
            descriptions: compController.descriptions
            onSendData: {
                detController.getPdfs(objectId,perimetreSave,systemSave,name);
                sendDataToDetails(objectId,perimetreSave,systemSave,name,description);
            }
            onTist: {
                if(tt=== "synoptique"){
                    compController.getComposants(objectIDPer,perimetreSave,systemSave)
                    synController.getComposants(objectIDPer,perimetreSave,systemSave)
                    synController.getImage(objectIDPer,perimetreSave,systemSave)
                    sendDataToSynoptique(objectIDPer,perimetreSave,systemSave);
                }else{
                    if(tt== "quiz"){
                        quizController.getQuiz(objectIDPer,perimetreSave,systemSave)
                        sendDataToQuiz(objectIDPer,perimetreSave,systemSave)
                    }
                }
            }
            onPopUpDialogBox: {
                if(button=== "modifier"){
                    dialogBoxModify.perimetreNameModifyText= nameText;
                    dialogBoxModify.perimetreDescriptionModifyText= descriptionText;
                    dialogBoxModify.perimetreIDModifyText= idText;
                    popupDialogBoxModify.popupDialogBoxModifyEnabled= true;
                }
                else{
                    dialogBoxID.msgErrorText= "Voulez vous vraiment supprimer le composant <b> "+nameText+"</b> de la base des données";
                    help= nameText;
                    popupDialogBoxRe.popupDialogBoxReEnabled= true;
                }
            }
        }

        BottomComponent{
            x: 0
            y: 628
            adminPrev: root.adminPrev
            onButtonClicked: {
                popupDialogBoxPerimetre.dialogBoxPerimetreEnabled = !popupDialogBoxPerimetre.dialogBoxPerimetreEnabled
            }
        }

        Popup{
            id: popup
            x: 5
            y: 583
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
        Popup{
            id: popupDialogBoxPerimetre
            x: 361
            y: 203
            property bool dialogBoxPerimetreEnabled: false
            visible: popupDialogBoxPerimetre.dialogBoxPerimetreEnabled
            modal: true
            closePolicy: Popup.NoAutoClose
            background: DialogBoxAdd{
                onButtonClicked: {
                    if(button=== "ajouter"){
                        compController.addComposant(objectIDPer,perimetreSave,systemSave,perimetreName,perimetreDescription);
                        mainComponent.namePerimetreAdd= perimetreName;
                        mainComponent.descriptionAdd= perimetreDescription;
                        mainComponent.idAdd= objectIDPer;
                        mainComponent.test= !mainComponent.test;
                        popupDialogBoxPerimetre.dialogBoxPerimetreEnabled= false;
                        popupText.text= "Ajouter avec succés";
                        popupRectangle.color= "#178C3D";
                        popupRectangle.opacity= 1;
                        popup.open();
                        exitTimer.start();
                    }
                    else{
                        popupDialogBoxPerimetre.dialogBoxPerimetreEnabled= false;
                    }
                }
            }
        }
        Popup{
            id: popupDialogBoxModify
            x: 361
            y: 203
            visible: popupDialogBoxModify.popupDialogBoxModifyEnabled
            property bool popupDialogBoxModifyEnabled: false
            modal: true
            closePolicy: Popup.NoAutoClose
            background: DialogBoxModify{
                id: dialogBoxModify
                onButtonClicked:{
                    if(button=== "modifier"){
                        compController.updateComposant(perimetreIDModifyText,perimetreSave,systemSave,perimetreNameModifyText,perimetreName,perimetreDescription);
                        mainComponent.namePerimetre= perimetreName;
                        mainComponent.description= perimetreDescription;
                        popupDialogBoxModify.popupDialogBoxModifyEnabled = false;
                        popupText.text= "Modifier avec succés";
                        popupRectangle.color= "#178C3D";
                        popupRectangle.opacity= 1;
                        popup.open();
                        exitTimer.start();
                    }
                    else{
                        popupDialogBoxModify.popupDialogBoxModifyEnabled= false;
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
                onButtonClicked: {
                    if(button=== "oui"){
                        compController.deleteComposant(objectIDPer,perimetreSave,systemSave,help);
                        synController.deleteComposant(objectIDPer,perimetreSave,systemSave,help)
                        popupDialogBoxRe.popupDialogBoxReEnabled= false;
                        popupText.text= "Supprimer avec succés";
                        popupRectangle.color= "#178C3D";
                        popupRectangle.opacity= 1;
                        popup.open();
                        exitTimer.start();
                        mainComponent.removeItem= !mainComponent.removeItem;
                    }
                    else{
                        popupDialogBoxRe.popupDialogBoxReEnabled= false;
                    }
                }
            }
        }
    }


}
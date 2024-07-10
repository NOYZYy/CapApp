import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects
import QtQuick.Studio.Components
import "components"
import "dialogBox"

Item {
    id: root
    signal backToLastPage()
    property variant questions: quizController.questions
    property variant answers: quizController.answers
    property variant rightAnswers: quizController.rightAnswers
    property bool adminPrev: false
    property int i:0
    property string objectIdPer
    property string perimetreSave
    property string systemSave
    width: 1150
    height: 745

    WindowHints {
        id: windowHints
        x: 0
        y: 0
        onMinimized: mainWindow.showMinimized()
        width: 1150
        height: 45
    }

    Rectangle {
        id: rectangle
        x: 0
        y: 45
        width: 1150
        height: 700
        color: "#f6f6f6"

        TopComponent {
            id: topComponent
            rootTitle: "Quiz"
            onBackTo: backToLastPage()
            x: 0
            y: 0
        }

        LeftComponent {
            id: leftComponent
            title: "Description"
            description: ""
            x: 0
            y: 64
        }

        BottomCompQuiz {
            id: bottomComponent
            x: 0
            y: 628
            adminPrev: root.adminPrev
            onButtonClicked: {
                if(button=== "Terminer"){
                    popupDialogBoxRe.popupDialogBoxReEnabled = true
                }else{
                    popupDialogBoxCsv.popupDialogBoxCsvEnabled = true
                }
            }
        }

        Rectangle {
            id: rectangle1
            x: 276
            y: 64
            width: 874
            height: 564
            color: "#f6f6f6"

            ScrollView {
                anchors.fill: parent
                contentWidth: -1
                Column {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
                    anchors.bottomMargin: 50
                    spacing: 15
                    anchors.fill: parent
                    Repeater {
                        id: repeater
                        anchors.fill: parent
                        model: ListModel{
                            id: questionModel
                            Component.onCompleted: {
                                if(questions.length > 0){
                                    do{
                                        questionModel.append({"questionQuiz": questions[i]});
                                        i++
                                    }while(i< questions.length)
                                }
                            }
                        }

                        Rectangle {
                            id: questionRec
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            width: 795
                            height: column.implicitHeight + 20
                            color: "#ffffff"
                            radius: 3

                            layer.enabled: true
                            layer.effect: DropShadowEffect {
                                id: dropShadow
                                color: "#c9c9c9"
                                spread: 0.05
                            }

                            Column {
                                id: column
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 20
                                anchors.topMargin: 10
                                spacing: 10

                                Text {
                                    id: question
                                    width: 739
                                    wrapMode: Text.WordWrap
                                    text: questionQuiz
                                    font.pixelSize: 18
                                    font.family: "Ubuntu Medium"
                                }

                                Rectangle {
                                    id: answersRec
                                    width: 700
                                    height: answerColumn.implicitHeight
                                    color: "#ffffff"
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15

                                    Column {
                                        id: answerColumn
                                        anchors.fill: parent
                                        Repeater{
                                            model: ListModel{
                                                id: answersModel
                                                Component.onCompleted: {
                                                    if(questions.length > 0){
                                                        console.log(answers)
                                                        //for (i = 0; i < questions.length; i++) {
                                                            for (var j = 0; j < 4; ++j){
                                                                answersModel.append({"answer": answers[i][j]})
                                                            }
                                                        //}
                                                    }
                                                }
                                            }

                                            Row {
                                                CheckBox {
                                                    id: checkBox
                                                    text: qsTr(" ")
                                                }

                                                Text {
                                                    text: answer
                                                    anchors.top: parent.top
                                                    anchors.topMargin: 10
                                                    wrapMode: Text.Wrap
                                                    width: 653
                                                    font.pointSize: 11
                                                    font.family: "Ubuntu Light"
                                                }
                                            }
                                        }
                                    }
                                }
                            }
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
                title: "Confirmation"
                msgErrorText: "Voulez-vous vraiment confirmer vos réponses au quiz ?"
                onButtonClicked: {
                    if(button=== "oui"){
                        popupDialogBoxRe.popupDialogBoxReEnabled= false;
                        popupText.text= "Supprimer avec succés";
                        popupRectangle.color= "#178C3D";
                        popupRectangle.opacity= 1;
                        popup.open();
                        exitTimer.start();
                    }
                    else{
                        popupDialogBoxRe.popupDialogBoxReEnabled= false;
                    }
                }
            }
        }
        Popup{
            id: popupDialogBoxCsv
            x: 361
            y: 203
            visible: popupDialogBoxCsv.popupDialogBoxCsvEnabled
            property bool popupDialogBoxCsvEnabled: false
            modal: true
            closePolicy: Popup.NoAutoClose
            background: DialogAddCsv{
                id: dialogBoxCsv
                title: "Confirmation"
                onButtonClicked: {
                    if(button=== "choisir"){
                        quizController.openFileExplorer();
                        msgErrorText= quizController.fileInformation
                        addEnabled= true;
                    }
                    else{
                        if(button=== "ajouter"){
                            popupDialogBoxCsv.popupDialogBoxCsvEnabled= false;
                            quizController.uploadCsv(objectIdPer,perimetreSave,systemSave);
                            popupText.text= "Supprimer avec succés";
                            popupRectangle.color= "#178C3D";
                            popupRectangle.opacity= 1;
                            popup.open();
                            exitTimer.start();
                        }
                        else{
                            popupDialogBoxCsv.popupDialogBoxCsvEnabled= false;
                        }
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

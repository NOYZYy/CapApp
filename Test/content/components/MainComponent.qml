import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects
import QtQuick.Studio.Components
import "../dialogBox"

Rectangle {
    id: rectangle2
    property variant ids
    property variant perimetres
    property variant descriptions
    signal sendData(string objectId,string name,string description)
    signal popUpDialogBox(string button,string nameText,string descriptionText,string idText)
    signal tist(string tt)
    property bool adminPrev: false
    property string rootTitle: ""
    property string description: ""
    property string namePerimetre: ""
    property string descriptionAdd: ""
    property string namePerimetreAdd: ""
    property string idAdd: ""
    property bool removeItem: false
    property bool test: true
    x: 276
    y: 64
    width: 874
    height: 564
    color: "#f6f6f6"
    layer.enabled: true

    ScrollView {
        id: scrollView
        x: 0
        y: 0
        anchors.fill: parent
        contentWidth: -1

        Column {
            id: column
            x: 0
            y: 0
            anchors.fill: parent
            topPadding: 20
            spacing: 20

            Row{
                x: 100
                spacing: 15
                NonFTRSolution{
                    id: nonFTRSolution
                    visible: (rootTitle=== "composant")
                }

                QuizButton{
                    id:quizButton
                    visible: (rootTitle=== "composant")
                    onQuizButtonClicked: {
                        tist("quiz");
                    }
                }

                SynoptiqueButton{
                    id: synoptiqueButton
                    visible: (rootTitle=== "composant")
                    onSynoptiqueButtonClicked: {
                        tist("synoptique");
                    }
                }
            }

            Repeater {
                id: repeater
                anchors.fill: parent
                model: ListModel {
                    id: perimetreListModel
                    Component.onCompleted: {
                        if(perimetres.length > 0){
                            for (var i = 0; i < perimetres.length; ++i) {
                                perimetreListModel.append({"objectID": ids[i], "name": perimetres[i], "description": descriptions[i] });
                            }
                        }
                    }
                    property int id: index
                    function createListElement(){
                        return{
                            "objectID": rectangle2.idAdd,
                            "name": rectangle2.namePerimetreAdd,
                            "description": rectangle2.descriptionAdd
                        }
                    }
                }

                Rectangle {
                    id: rectanglePer
                    property string a: "value"
                    onAChanged: name= a;
                    x: 100
                    y: 15
                    width: 600
                    height: 71
                    color: "#ffffff"
                    radius: 5
                    layer.enabled: true
                    layer.effect: DropShadowEffect {
                        id: dropShadow
                        color: "#c9c9c9"
                        spread: 0.05
                    }
                    MouseArea {
                        id: rectanglePerClick
                        x: 0
                        y: 0
                        width: 560
                        height: 71
                        visible: !optionsList.optionsListEnabled
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onEntered: rectanglePer.color= "#f4f4f4";
                        onExited: rectanglePer.color= "#ffffff";
                        onClicked: {
                            sendData(objectID,name,description);

                        }

                    }

                    Text {
                        id: nameText
                        x: 16
                        y: 8
                        width: 93
                        height: 19
                        text: name
                        font.pixelSize: 20
                        font.family: "Ubuntu Medium"
                    }

                    Text {
                        id: descriptionText
                        x: 22
                        y: 33
                        text: description
                        font.pixelSize: 14
                        font.family: "Ubuntu Light"
                    }

                    MouseArea {
                        id: options
                        x: 554
                        y: 0
                        width: 38
                        height: 22
                        visible: root.adminPrev
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onEntered: optionsTree.color= "#808080";
                        onExited: optionsTree.color= "#a9a9a9";

                        Connections {
                            target: options
                            onClicked: popupOptionsList.optionsListEnabled = true
                        }

                        Text {
                            id: optionsTree
                            x: 0
                            y: 0
                            width: 38
                            height: 22
                            color: "#a9a9a9"
                            text: qsTr("...")
                            font.pixelSize: 21
                            horizontalAlignment: Text.AlignHCenter
                            styleColor: "#a9a9a9"
                            font.family: "Ubuntu Medium"
                        }
                    }

                    Popup{
                        id: popupOptionsList
                        width: 116
                        height: 70
                        x: options.x+10
                        y: options.y+options.height+5
                        property bool optionsListEnabled: false
                        visible: popupOptionsList.optionsListEnabled
                        background: Rectangle {
                            id: optionsList
                            x: 0
                            y: 0
                            anchors.fill: parent
                            color: "#ffffff"
                            radius: 5
                            layer.enabled: true
                            layer.effect: DropShadowEffect {
                                id: dropShadow1
                                color: "#e4e0e0"
                                spread: 0.25
                            }

                            MouseArea {
                                id: modify
                                x: 0
                                y: 0
                                width: 116
                                height: 35
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onEntered: textModify.color= "#808080";
                                onExited: textModify.color= "#a9a9a9";

                                Text {
                                    id: textModify
                                    x: 32
                                    y: 11
                                    color: "#a9a9a9"
                                    text: qsTr("Modifier")
                                    font.pixelSize: 14
                                    font.family: "Ubuntu Light"
                                }

                                Connections {
                                    target: modify
                                    onClicked: {
                                        popUpDialogBox("modifier",name,description,objectID);
                                        perimetreListModel.id= index;
                                        popupOptionsList.optionsListEnabled= false;
                                    }
                                }

                            }

                            MouseArea {
                                id: delet
                                x: 0
                                y: 35
                                width: 116
                                height: 35
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onEntered: textDelet.color= "#808080";
                                onExited: textDelet.color= "#a9a9a9";

                                Text {
                                    id: textDelet
                                    x: 26
                                    y: 8
                                    color: "#a9a9a9"
                                    text: qsTr("Supprimer")
                                    font.pixelSize: 14
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "Ubuntu Light"
                                }

                                Connections {
                                    target: delet
                                    onClicked: {
                                        popUpDialogBox("supprimer",name,"","");
                                        perimetreListModel.id= index;
                                        popupOptionsList.optionsListEnabled= false;
                                    }
                                }
                            }
                        }
                        onOpened: {
                            scrollView.wheelEnabled = false;
                        }
                        onClosed: {
                            scrollView.wheelEnabled = true;
                            popupOptionsList.optionsListEnabled= false;
                        }
                    }

                }
            }
        }
    }
    onTestChanged: {
        perimetreListModel.append(perimetreListModel.createListElement());
    }
    onNamePerimetreChanged: {
        perimetreListModel.setProperty(perimetreListModel.id,"name",namePerimetre);
    }
    onDescriptionChanged: {
        perimetreListModel.setProperty(perimetreListModel.id,"description",description);
    }
    onRemoveItemChanged: {
        perimetreListModel.remove(perimetreListModel.id);
    }

}

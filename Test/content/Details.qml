import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects
import QtQuick.Pdf
import "components"


Item{
    signal backToLastPage()
    signal changrHeight()
    id: root
    property bool fileChosen: false
    property string perimetreDescription: ""
    property string perimetreName: ""
    property bool adminPrev: false
    property string perimetreSave: ""
    property string systemSave: perimetreName
    property string objectIDPer: ""
    property bool pdfPopupEnabled: false
    width: 1150
    height: 745
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
            rootTitle: "Detailles"
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

        BottomComponent{
            x: 0
            y: 628
            height: 72
            adminPrev: false
        }

        Rectangle {
            id: blocker
            anchors.fill: parent
            color: "transparent"
            visible: !fileChosen
            z: 1000
        }

        Connections {
            target: detController
            onFileSelected: {
                fileChosen = true;
            }
        }
        Rectangle {
            id: tist
            x: 276
            y: 64
            width: 875
            height: 564
            color: "#f6f6f6"

            Column {
                id: column
                anchors.fill: parent
                Repeater {
                    id: repeater
                    anchors.fill: parent
                    model: ListModel {
                        id: detailListModel
                        ListElement{
                            name: "conseption 3D"
                            type: "pdf3d"
                            file: "pdf3d.pdf"
                        }
                        ListElement{
                            name: "conseption 2D"
                            type: "pdf2d"
                            file: "pdf2d.pdf"
                        }
                        ListElement{
                            name: "règles de métier"
                            type: "regle"
                            file: "regle.pdf"
                        }
                    }

                    Rectangle {
                        x: 100
                        width: 660
                        height: 170
                        color: "#f6f6f6"

                        Text {
                            id: textRec
                            y: 10
                            text: name
                            font.pixelSize: 16
                            font.family: "Ubuntu Medium"
                        }

                        Rectangle {
                            id: rectangle
                            y: 40
                            width: 660
                            height: 102
                            color: "#ffffff"
                            radius: 4
                            layer.enabled: true
                            layer.effect: DropShadowEffect {
                                id: dropShadow
                                color: "#c9c9c9"
                                spread: 0.01
                            }

                            Text {
                                id: ajouter
                                x: 403
                                y: 77
                                color: "#0f878a"
                                text: qsTr("Ajouter")
                                font.pixelSize: 15
                                font.family: "Ubuntu Light"

                                MouseArea {
                                    id: ajouterButton
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: ajouter.color= "#0F434A";
                                    onExited: ajouter.color= "#0f878a";
                                    onClicked: {
                                        detController.openFileExplorer(objectIDPer,perimetreSave,systemSave,perimetreName,type);
                                    }
                                }
                            }

                            Text {
                                id: modifier
                                x: 485
                                y: 77
                                color: "#0f878a"
                                text: qsTr("Modifier")
                                font.pixelSize: 15
                                font.family: "Ubuntu Light"

                                MouseArea {
                                    id: modifierButton
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: modifier.color= "#0F434A";
                                    onExited: modifier.color= "#0f878a";
                                    onClicked: {
                                        detController.openFileExplorer(objectIDPer,perimetreSave,systemSave,perimetreName,type);
                                    }
                                }
                            }

                            Text {
                                id: supprimer
                                x: 575
                                y: 77
                                color: "#0f878a"
                                text: qsTr("Supprimer")
                                font.pixelSize: 15
                                font.family: "Ubuntu Light"

                                MouseArea {
                                    id: supprimerButton
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: supprimer.color= "#0F434A";
                                    onExited: supprimer.color= "#0f878a";
                                }
                            }

                            Text {
                                id: pdf
                                x: 113
                                y: 32
                                color: "#0f878a"
                                text: {
                                    if(getInfo(type))
                                        file;
                                    else
                                        qsTr("Aucun fichier ni associé pour le moment")
                                }
                                font.pixelSize: 15
                                font.family: "Ubuntu Light"

                                MouseArea {
                                    id: pdfButton
                                    anchors.fill: parent
                                    visible: getInfo(type)
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        detController.openPdf("file:///C:/Users/NOYZz/Documents/"+file)
                                        pdfPopupEnabled= true
                                    }
                                    Connections{
                                        target: detController
                                        onPdfChanged: {
                                            pdfButton.visible= true;
                                            pdf.text= file;
                                        }
                                    }
                                }
                            }

                            Image {
                                x: 23
                                y: 19
                                source: "images/pdf-rgb.png"
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }
                }
            }
        }
    }
    function getInfo(type){
        if(type=== "pdf2d")
            return detController.pdf2d;
        if(type ==="pdf3d")
            return detController.pdf3d;
        if(type=== "regle")
            return detController.regle;
    }
}


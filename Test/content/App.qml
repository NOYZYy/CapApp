// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Studio.Components
import "components"

Window {
    id: mainWindow
    property int currentHeight: 545
    property int currentWidth: 400
    property bool adminPrev: false
    property bool enterPressed: false
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.CustomizeWindowHint
    height: currentHeight
    width: currentWidth
    visible: true
    title: "CapFormations"
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2


    StackView {
        id: stackView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        initialItem: authentificationComponent
        focus: true
        Keys.onPressed: (event)=> {
            if (event.key === 16777220) {
                if(currentItem.toString().substring(0,4)=== "Auth"){
                    mainWindow.enterPressed= !mainWindow.enterPressed;
                }
            }
        }
    }


    Component {
        id: perimetreComponent
        Perimetre {
            adminPrev: mainWindow.adminPrev
            width: 1150
            height: 745
            onSendDataToSysteme: {
                stackView.push(systemeComponent.createObject(mainWindow, {
                    adminPrev: mainWindow.adminPrev,
                    perimetreName: name,
                    perimetreDescription: description,
                    objectIDPer: index
                }))
            }
            onBackToLastPage:{
                mainWindow.currentHeight= 545;
                mainWindow.currentWidth= 400;
                stackView.pop();
            }
        }
    }

    Component {
        id: authentificationComponent
        Authentification {
            enterPressed: mainWindow.enterPressed
            width: 400
            height: 545
            onButtonClicked: {
                perController.getPerimetres();
                if (button === "entrer") {
                    mainWindow.adminPrev= true;
                    stackView.push(perimetreComponent)
                    mainWindow.currentHeight= 745;
                    mainWindow.currentWidth= 1150;
                } else if (button === "formations") {
                    mainWindow.adminPrev= false;
                    stackView.push(perimetreComponent)
                    mainWindow.currentHeight= 745;
                    mainWindow.currentWidth= 1150;
                }
            }
        }
    }

    Component{
        id: systemeComponent
        Systeme{
            width: 1150
            height: 745
            onBackToLastPage : {
                mainWindow.currentHeight= 745;
                stackView.pop()
            }
            onSendDataToComposant:  {
                stackView.push(composantComponent.createObject(mainWindow, {
                    adminPrev: mainWindow.adminPrev,
                    perimetreName: name,
                    perimetreDescription: description,
                    perimetreSave: perimetre,
                    objectIDPer: index
                }))
            }
        }
    }

    Component{
        id: composantComponent
        Composant{
            width: 900
            height: 1000
            onBackToLastPage : {
                mainWindow.currentHeight= 745;
                stackView.pop()
            }
            onSendDataToDetails: {
                stackView.push(detailsComponent.createObject(mainWindow, {
                    adminPrev: mainWindow.adminPrev,
                    perimetreName: name,
                    perimetreDescription: description,
                    perimetreSave: perimetre,
                    systemSave: system,
                    objectIDPer: index
                }))
                // mainWindow.currentHeight= 1000;
                // mainWindow.currentWidth= 900;
                // stackView.push(pdfViewerComponent.createObject(mainWindow))
            }
            onSendDataToSynoptique: {
                stackView.push(synoptiqueComponent.createObject(mainWindow, {
                    adminPrev: mainWindow.adminPrev,
                    perimetreSave: perimetre,
                    systemSave: name,
                    objectIDPer: index
                }))
            }
            onSendDataToQuiz: {
                stackView.push(quizComponent.createObject(mainWindow, {
                    adminPrev: mainWindow.adminPrev,
                    perimetreSave: perimetre,
                    systemSave: name,
                    objectIdPer: index
                }))
            }
        }
    }

    Component{
        id: detailsComponent
        Details{
            width: 1150
            height: 745
            onBackToLastPage : {
                mainWindow.currentHeight= 745;
                stackView.pop()
            }
        }
    }

    Component{
        id: pdfViewerComponent
        PdfViewer{
            width: 1150
            height: 745
        }
    }

    Component{
        id: synoptiqueComponent
        Synoptique{
            width: 1150
            height: 745
            onBackToLastPage : {
                mainWindow.currentHeight= 745;
                stackView.pop()
            }
            onSendDataToDetails: {
                stackView.push(detailsComponent.createObject(mainWindow, {
                    adminPrev: mainWindow.adminPrev,
                    perimetreName: name,
                    perimetreDescription: description,
                    perimetreSave: perimetre,
                    systemSave: system,
                    objectIDPer: index
                }))
            }
        }
    }

    Component{
        id: quizComponent
        Quiz{
            width: 1150
            height: 745
            onBackToLastPage : {
                mainWindow.currentHeight= 745;
                stackView.pop()
            }
        }
    }

    Behavior on currentWidth {
        NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
    }

    Component.onCompleted: {
        stackView.push(authentificationComponent);

    }
}


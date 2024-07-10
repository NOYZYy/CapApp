import QtQuick 2.15
import QtQuick.Controls 2.15
import "dialogBox"
import "components"

Item {
    signal backToLastPage()
    id: root
    width: 1150
    height: 700
    property string perimetreDescription: ""
    property string perimetreName: ""
    property bool adminPrev: false

    TopComponent {
        width: 1150
        height: 64
        rootTitle: "Nom FTR et Solutions"
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
        adminPrev: root.adminPrev
        onButtonClicked: {
            popupDialogBoxPerimetre.dialogBoxPerimetreEnabled = !popupDialogBoxPerimetre.dialogBoxPerimetreEnabled
        }
    }

    Rectangle {
        id: rectangle
        x: 277
        y: 64
        width: 873
        height: 564
        color: "#f6f6f6"
    }
}

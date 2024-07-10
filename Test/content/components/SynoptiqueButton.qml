import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Effects

Rectangle {
    id: rectanglePer
    signal synoptiqueButtonClicked()
    x: 100
    width: 190
    height: 71
    color: "#214554"
    radius: 5
    layer.enabled: true
    layer.effect: DropShadowEffect {
        id: dropShadow
        color: "#c9c9c9"
        spread: 0.05
    }

    MouseArea {
        id: rectanglePerClick
        width: 560
        height: 71
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: rectanglePer.color= "#173340";
        onExited: rectanglePer.color= "#214554";
        onClicked: {
            synoptiqueButtonClicked();
        }

    }

    Text {
        id: nameText
        x: 16
        y: 8
        width: 93
        height: 19
        color: "#ffffff"
        text: "Synoptique"
        font.pixelSize: 20
        font.family: "Ubuntu Medium"
    }

    Text {
        id: descriptionText
        x: 22
        y: 33
        color: "#ffffff"
        text: "description"
        font.pixelSize: 14
        font.family: "Ubuntu Light"
    }
}

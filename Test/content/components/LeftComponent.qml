import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Studio.Components

Rectangle {
    id: rectangle1
    x: 0
    y: 64
    width: 276
    height: 564
    color: "#ffffff"
    property string description: ""
    property string title: ""

    Text {
        id: title
        x: 28
        y: 25
        width: 143
        height: 26
        text: rectangle1.title
        font.pixelSize: 22
        font.family: "Ubuntu Medium"
    }

    BorderItem {
        id: border2
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

        Text {
            id: description
            x: 32
            y: 62
            width: 236
            height: 475
            text: rectangle1.description
            font.pixelSize: 14
            wrapMode: Text.WordWrap
            font.family: "Ubuntu Light"
        }
    }
}

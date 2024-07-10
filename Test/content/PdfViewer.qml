import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Pdf

Rectangle {
        id: container
        width: 500
        height: 1000
        anchors.fill: parent
        color: "transparent"

        // Content to be zoomed
        PdfMultiPageView  {
            id: content
            width: 500
            height: 1000
            document: PdfDocument {
                id: pdfView
                source: "file:///C:/Users/NOYZz/Documents/pdf2d.pdf"
            }
        }

        // PinchArea for touch gestures
        PinchArea {
            anchors.fill: parent
            onPinchUpdated: {
                content.scale *= pinch.scale
            }
        }

        // MouseArea for mouse wheel events
        MouseArea {
            anchors.fill: parent
            onWheel: {
                if (wheel.angleDelta.y > 0) {
                    content.scale *= 1.1 // Zoom in
                } else {
                    content.scale /= 1.1 // Zoom out
                }
            }
        }
    }

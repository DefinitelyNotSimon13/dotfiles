import QtQuick
import "../common"

Text {
    id: clockText
    text: Qt.formatDateTime(new Date(), "HH:mm")
    color: Theme.aqua
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm")
    }
}

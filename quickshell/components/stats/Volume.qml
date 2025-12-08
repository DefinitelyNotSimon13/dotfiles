import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "../../common"

Text {
    id: root

    property int volumeLevel: 0

    text: (Pipewire.defaultAudioSink?.audio.muted ? "  " : "  ") + (Pipewire.defaultAudioSink?.audio.volume * 100).toFixed(0) + "%"
    color: Theme.purple
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
    Layout.rightMargin: 8
}

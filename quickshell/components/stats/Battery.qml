import QtQuick
import Quickshell.Services.UPower
import QtQuick.Layouts
import "../../common"

Text {
    id: root

    property var upower: UPower

    text: (upower.onBattery ? "󰂁 " : " ") + (upower.displayDevice.percentage * 100).toFixed(0) + "%"

    color: Theme.blue
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
    Layout.rightMargin: 8
}

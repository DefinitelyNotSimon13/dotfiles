import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import "../../common"

Text {
    id: root

    property int cpuTemp: 0

    text: " " + cpuTemp + "°"
    color: Theme.yellow
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
    Layout.rightMargin: 8

    Process {
        id: cpuTempProc
        command: ["sh", "-c", "head -1 /sys/class/thermal/thermal_zone1/temp"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var temp = parseInt(data) / 1000;
                if (!Number.isFinite(temp))
                    return;
                root.cpuTemp = Math.round(temp);
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuTempProc.running = true
    }
}

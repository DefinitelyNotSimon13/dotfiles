import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import "../../common"

Text {
    id: root

    property int cpuUsage: 0
    property double _lastCpuIdle: 0
    property double _lastCpuTotal: 0

    text: " " + cpuUsage + "%"
    color: Theme.yellow
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
    Layout.rightMargin: 8

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;

                var parts = data.trim().split(/\s+/);
                var user = parseInt(parts[1]) || 0;
                var nice = parseInt(parts[2]) || 0;
                var system = parseInt(parts[3]) || 0;
                var idle = parseInt(parts[4]) || 0;
                var iowait = parseInt(parts[5]) || 0;
                var irq = parseInt(parts[6]) || 0;
                var softirq = parseInt(parts[7]) || 0;

                var total = user + nice + system + idle + iowait + irq + softirq;
                var idleTime = idle + iowait;

                if (root._lastCpuTotal > 0) {
                    var totalDiff = total - root._lastCpuTotal;
                    var idleDiff = idleTime - root._lastCpuIdle;
                    if (totalDiff > 0) {
                        root.cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff);
                    }
                }

                root._lastCpuTotal = total;
                root._lastCpuIdle = idleTime;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }
}

import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import "../../common"

Text {
    id: root

    property int diskUsage: 0

    text: "Disk: " + diskUsage + "%"
    color: Theme.blue
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true
    Layout.rightMargin: 8

    Process {
        id: diskProc
        command: ["sh", "-c", "df / | tail -1"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var percentStr = parts[4] || "0%";
                root.diskUsage = parseInt(percentStr.replace('%', '')) || 0;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: diskProc.running = true
    }
}

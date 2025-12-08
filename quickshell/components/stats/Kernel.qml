import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import "../../common"

Text {
    id: root

    property string kernelVersion: "Linux"

    text: kernelVersion
    color: Theme.red
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true

    Process {
        id: kernelProc
        command: ["uname", "-r"]
        stdout: SplitParser {
            onRead: data => {
                if (data)
                    root.kernelVersion = data.trim();
            }
        }
        Component.onCompleted: running = true
    }
}

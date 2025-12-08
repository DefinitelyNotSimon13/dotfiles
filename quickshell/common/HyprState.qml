pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: hypr

    readonly property string activeWindow: _activeWindow
    readonly property string currentLayout: _currentLayout

    property string _activeWindow: "Window"
    property string _currentLayout: "Tile"

    Process {
        id: windowProc
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.initialTitle // empty'"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim())
                    hypr._activeWindow = data.trim();
            }
        }
    }

    Process {
        id: layoutProc
        command: ["sh", "-c", "hyprctl activewindow -j | jq -r 'if .floating then \"Floating\" elif .fullscreen == 1 then \"Fullscreen\" else \"Tiled\" end'"]
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim())
                    hypr._currentLayout = data.trim();
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            windowProc.running = true;
            layoutProc.running = true;
        }
    }

    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            windowProc.running = true;
            layoutProc.running = true;
        }
    }
}

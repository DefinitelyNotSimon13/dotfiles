import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import Quickshell.Widgets
import "components"
import "common"

PanelWindow {
    required property var modelData
    screen: modelData

    implicitHeight: 30
    color: Theme.bg

    anchors {
        top: true
        left: true
        right: true
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.bg

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                width: 16
            }

            Session {}

            Item {
                width: 8
            }

            Clock {}

            Item {
                width: 8
            }

            WorkspaceIndicator {}

            Separator {}

            Text {
                text: HyprState.activeWindow
                color: Theme.purple
                font.pixelSize: Theme.fontSize
                font.family: Theme.fontFamily
                font.bold: true
                Layout.fillWidth: true
                Layout.leftMargin: 8
                elide: Text.ElideRight
                maximumLineCount: 1
            }

            StatsRow {}
        }
    }
}

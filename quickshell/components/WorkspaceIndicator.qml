import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../common"

Repeater {
    model: 9

    Rectangle {
        id: root
        Layout.preferredWidth: 20
        Layout.preferredHeight: parent.height
        color: "transparent"

        property var workspace: Hyprland.workspaces.values.find(ws => ws.id === index + 1) ?? null
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
        property bool hasWindows: workspace !== null

        Text {
            text: index + 1
            color: root.isActive ? Theme.cyan : (root.hasWindows ? Theme.cyan : Theme.muted)
            font.pixelSize: Theme.fontSize
            font.family: Theme.fontFamily
            font.bold: true
            anchors.centerIn: parent
        }

        Rectangle {
            width: 20
            height: 3
            color: root.isActive ? Theme.purple : Theme.bg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
    }
}

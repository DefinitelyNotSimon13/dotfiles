pragma ComponentBehavior: Bound

import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

MouseArea {
    id: root

    required property SystemTrayItem modelData

    implicitWidth: 10
    implicitHeight: 10

    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: event => {
        if (event.button === Qt.LeftButton)
            modelData.activate();
        else
            modelData.secondaryActivate();
    }
    IconImage {
        id: icon

        anchors.fill: parent
        source: root.getTrayIcon(root.modelData.id, root.modelData.icon)

        asynchronous: false

    }

    // ColouredIcon {
    //     id: icon
    //
    //     colour: Colours.palette.m3secondary
    //     layer.enabled: Config.bar.tray.recolour
    // }
function getTrayIcon(id: string, icon: string): string {
  console.log("Test with: " + id + " icon: " + icon);
        // for (const sub of Config.bar.tray.iconSubs)
        //     if (sub.id === id)
        //         return sub.image ? Qt.resolvedUrl(sub.image) : Quickshell.iconPath(sub.icon);

        if (icon.includes("?path=")) {
            const [name, path] = icon.split("?path=");
            icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
        }
        console.log("Icon: ", icon)
        return icon;
    }
}

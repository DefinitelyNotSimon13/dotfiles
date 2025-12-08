import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import "../../common"

Text {
    id: root

    property bool isConnected: false
    property bool isWifi: false
    property int networkStrength: 0
    property string ssid: "SSID"

    text: isConnected ? (isWifi ? `  ${ssid} (${networkStrength}%)` : "󰈀 Connected") : "⚠ Disconnected"

    color: Theme.purple
    font.pixelSize: Theme.fontSize
    font.family: Theme.fontFamily
    font.bold: true

    Process {
        id: networkProc
        command: ["sh", "-c", "nmcli -t  -f NAME,TYPE,ACTIVE,STATE c show | head -1"]
        stdout: SplitParser {
            onRead: data => {
                if (!data || !data.trim())
                    return;

                var parts = data.trim().split(":");

                var name = parts[0];
                var type = parts[1];
                var activeStr = parts[2];

                root.ssid = name;
                root.isWifi = (type === "802-11-wireless");
                root.isConnected = (activeStr === "yes");
            }
        }
    }

    Process {
        id: networkStrengthProc
        command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL device wifi | awk '/\\*/{print $2}'"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                root.networkStrength = parseInt(data) || 0;
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            networkProc.running = true;
            if (root.isConnected && root.isWifi) {
                networkStrengthProc.running = true;
            }
        }
    }
}

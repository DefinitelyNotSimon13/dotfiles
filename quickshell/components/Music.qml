pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../common"

RowLayout {
    id: root
    spacing: 8
    Layout.alignment: Qt.AlignVCenter

    // pick an active player: prefer a playing one, else the first
    property MprisPlayer player: {
        for (const p of Mpris.players.values) {
            if (p.isPlaying)
                return p;
        }

        for (const p of Mpris.players.values) {
                return p;
        }
        return Mpris.players.count > 0 ? Mpris.players[0] : null;
    }

    // hide the whole widget if there is no player
    visible: player !== null

    IconImage {
        id: playerIcon

        visible: root.player && !!root.player.desktopEntry
        implicitWidth: 15
        implicitHeight: 15

        source: getIcon(root.player)
        // desktopEntry is the .desktop name, perfect for icon lookup
        // source: root.player && root.player.desktopEntry
        //     ? Quickshell.iconPath(root.player.desktopEntry)
        //     : ""

        mipmap: true
        asynchronous: true
    }

    function getIcon(player: MprisPlayer): string {
      if(!player || !player.desktopEntry) return null;
      console.log("DesktopEntryString: ", player.desktopEntry);
      const desktopEntry = DesktopEntries.heuristicLookup(player.desktopEntry);
      console.log("Results in:", desktopEntry)
      if(!desktopEntry) return null;
      console.log("Icon: " + desktopEntry.icon);
      return Quickshell.iconPath(desktopEntry.icon);
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 0

        Text {
            visible: !!root.player
            text: (root.player
                  ? (root.player.trackArtist
                        || root.player.identity
                        || "Unknown Artist")
                  : "") + " "
            color: Theme.gray
            font.pixelSize: Theme.fontSize
            font.family: Theme.fontFamily
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        // Title
        Text {
            text: (root.player
                  ? (root.player.trackTitle || "Unknown Title")
                  : "No media") + " "
            color: Theme.fg
            font.pixelSize: Theme.fontSize
            font.family: Theme.fontFamily
            font.bold: true
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        Text {
                id: currentPos
                visible: root.player && root.player.length > 0
                text: (formatTime(root.player.position)) + " "
                color: Theme.gray
                font.pixelSize: Theme.fontSize - 2
                font.family: Theme.fontFamily
            }

        // Position bar
        Rectangle {
            id: progressBar
            width: 100
            height: 4
            radius: height / 2
            color: Theme.muted
            visible: root.player && root.player.length > 0
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: parent.width * root.progress
                radius: parent.radius
                color: player.isPlaying ?  Theme.purple : Theme.gray
            Layout.alignment: Qt.AlignVCenter
            }
        }
Text {
                id: totalPos
                visible: root.player && root.player.length > 0
                text: " " + formatTime(root.player.length)
                color: Theme.gray
                font.pixelSize: Theme.fontSize - 2
                font.family: Theme.fontFamily
            }
    }
    function formatTime(seconds) {
        if (!seconds || seconds <= 0)
            return "0:00";

        const mins = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        return mins + ":" + (secs < 10 ? "0" + secs : secs);
    }

    // 0..1 progress in current track
    property real progress: {
        if (!root.player || root.player.length <= 0)
            return 0;
        return Math.max(0, Math.min(1, root.player.position / root.player.length));
    }

    // poke positionChanged so the binding above actually updates
    Timer {
        interval: 1000
        running: root.player
                 && root.player.playbackState == MprisPlaybackState.Playing
        repeat: true
        onTriggered: {
            if (root.player)
                root.player.positionChanged();
        }
    }
}

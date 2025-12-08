import QtQuick
import Quickshell
import Quickshell.Services.Greetd
import "widgets"
import "common"

ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {
            modelData: modelData
        }
    }

    VolumeChangeIndicator {}
}

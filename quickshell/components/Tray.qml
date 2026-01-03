pragma ComponentBehavior: Bound

import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

Repeater {
  id: items
  model: SystemTray.items

  TrayItem {}

}


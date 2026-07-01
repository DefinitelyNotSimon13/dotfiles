hl.bind(MAIN_MOD .. ' + COMMA', hl.dsp.exec_cmd 'swaync-client --close-latest', { description = 'Dismiss last notification' })
hl.bind(MAIN_MOD .. ' + SHIFT + COMMA', hl.dsp.exec_cmd 'swaync-client --close-all', { description = 'Dismiss all notifications' })
hl.bind(MAIN_MOD .. ' + CTRL + COMMA', hl.dsp.exec_cmd 'swaync-client --toggle-panel', { description = 'Open notifications panel' })
hl.bind(
  MAIN_MOD .. ' + ALT + COMMA',
  hl.dsp.exec_cmd "swaync-client --toggle-dnd && swaync-client --get-dnd | grep -q 'true' && notify-send 'Silenced notifications' || notify-send 'Enabled notifications'",
  { description = 'Toggle silencing notifications' }
)

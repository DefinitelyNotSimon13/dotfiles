hl.bind(MAIN_MOD .. ' + Super_L', hl.dsp.exec_cmd 'fuzzel', { release = true })
hl.bind(MAIN_MOD .. ' + RETURN', hl.dsp.exec_cmd 'ghostty +new-window')
hl.bind(MAIN_MOD .. ' + ALT + L', hl.dsp.exec_cmd 'hyprlock')
hl.bind(MAIN_MOD .. ' + E', hl.dsp.exec_cmd 'nautilus')

local hyprshot = os.getenv 'HOME' .. '/.local/bin/hyprshot'
hl.bind(MAIN_MOD .. ' + S', hl.dsp.exec_cmd(hyprshot .. ' -m region'), { description = 'Region screenshot' })
hl.bind(MAIN_MOD .. ' + ALT + S', hl.dsp.exec_cmd(hyprshot .. ' -m window'), { description = 'Window screenshot' })
hl.bind(MAIN_MOD .. ' + SHIFT + S', hl.dsp.exec_cmd(hyprshot .. ' -m output'), { description = 'Monitor screenshot' })

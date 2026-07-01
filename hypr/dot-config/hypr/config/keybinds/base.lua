for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(MAIN_MOD .. ' + ' .. key, hl.dsp.focus { workspace = i })
  hl.bind(MAIN_MOD .. ' + SHIFT + ' .. key, hl.dsp.window.move { workspace = i })
end

hl.bind(MAIN_MOD .. ' + SHIFT + H', hl.dsp.window.move { direction = 'left' })
hl.bind(MAIN_MOD .. ' + SHIFT + L', hl.dsp.window.move { direction = 'right' })
hl.bind(MAIN_MOD .. ' + SHIFT + K', hl.dsp.window.move { direction = 'up' })
hl.bind(MAIN_MOD .. ' + SHIFT + J', hl.dsp.window.move { direction = 'down' })
hl.bind(MAIN_MOD .. ' + SHIFT + right', hl.dsp.window.resize { x = 10, y = 0, relative = true })
hl.bind(MAIN_MOD .. ' + SHIFT + left', hl.dsp.window.resize { x = -10, y = 0, relative = true })
hl.bind(MAIN_MOD .. ' + SHIFT + up', hl.dsp.window.resize { x = 0, y = -10, relative = true })
hl.bind(MAIN_MOD .. ' + SHIFT + down', hl.dsp.window.resize { x = 0, y = 10, relative = true })
hl.bind(MAIN_MOD .. ' + code:123', hl.dsp.exec_cmd 'playerctl volume 1')

hl.bind(MAIN_MOD .. ' + mouse_down', hl.dsp.focus { workspace = 'e+1' })
hl.bind(MAIN_MOD .. ' + mouse_up', hl.dsp.focus { workspace = 'e-1' })

hl.bind(MAIN_MOD .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(MAIN_MOD .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind(MAIN_MOD .. ' + C', hl.dsp.window.close())
hl.bind(MAIN_MOD .. ' + SHIFT + M', hl.dsp.exit())
hl.bind(MAIN_MOD .. ' + V', hl.dsp.window.float { action = 'toggle' })
hl.bind(MAIN_MOD .. ' + P', hl.dsp.window.pseudo())
hl.bind(MAIN_MOD .. ' + J', hl.dsp.layout 'togglesplit')
hl.bind(MAIN_MOD .. ' + F', hl.dsp.window.fullscreen { mode = 0 })
hl.bind(MAIN_MOD .. ' + H', hl.dsp.focus { direction = 'left' })
hl.bind(MAIN_MOD .. ' + L', hl.dsp.focus { direction = 'right' })
hl.bind(MAIN_MOD .. ' + K', hl.dsp.focus { direction = 'up' })
hl.bind(MAIN_MOD .. ' + J', hl.dsp.focus { direction = 'down' })

hl.on('hyprland.start', function()
  hl.exec_cmd 'hyprctl setcursor catppuccin-mocha-dark-cursors 24'
  hl.exec_cmd 'GTK_IM_MODULE=simple ghostty --gtk-single-instance=true --shell-integration-features=ssh-env'
  hl.exec_cmd 'wl-paste --watch cliphist store'
  hl.exec_cmd 'nm-applet'
  hl.exec_cmd 'waybar & hyprpaper & hypridle'
end)

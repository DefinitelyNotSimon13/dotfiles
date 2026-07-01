hl.config {
  general = {
    gaps_in = 0,
    gaps_out = 0,

    border_size = 2,

    col = {
      active_border = 'rgba(33ccffee)',
      inactive_border = 'rgba(595959ff)',
    },

    resize_on_border = true,

    allow_tearing = false,

    layout = 'dwindle',
  },

  dwindle = {
    preserve_split = true,
  },

  decoration = {
    rounding = 0,
    rounding_power = 0,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
}

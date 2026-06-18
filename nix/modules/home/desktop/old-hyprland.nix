{ ... }:
{
  flake.modules.home.old-hyprland =
    {
      pkgs,
      lib,
      config,
      self,
      ...
    }:
    let
      monitors = config.preferences.monitors;

      mkMonitorSettings =
        lib.mapAttrsToList (
          name: m:
          {
            output = name;
            mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
            scale = m.scale;
          }
          // lib.optionalAttrs (m.transform != 0) { transform = m.transform; }
        ) monitors;

      mkWorkspaceRules =
        n:
        let
          primary = lib.findFirst (m: m.primary) (throw "preferences.monitors: no monitor has primary = true") (
            lib.mapAttrsToList (name: m: m // { inherit name; }) monitors
          );
        in
        map (i: {
          workspace = toString i;
          monitor = primary.name;
          default = i == 1;
        }) (lib.range 1 n);

      mkHyprlandBinds =
        lib.concatMapStringsSep "\n" (
          b: ''hl.bind("${b.mods} + ${b.key}", hl.dsp.exec_cmd("${b.exec}"))''
        ) config.preferences.keybinds;
    in
    {
      home.packages = with pkgs; [
        hyprcursor
        hyprshot
      ];

      home.file.".local/share/icons/catppuccin-mocha-dark-cursors" = {
        source = "${pkgs.catppuccin-cursors.mochaDark}/share/icons/catppuccin-mocha-dark-cursors";
        recursive = true;
      };

      programs.fuzzel.enable = true;
      programs.waybar.enable = true;

      stylix.targets.hyprland = {
        enable = true;
        colors.enable = false;
      };

      services.hyprpaper.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";

        settings = {
          monitor = mkMonitorSettings;
          workspace_rule = mkWorkspaceRules 7;

          config = {
            cursor = {
              inactive_timeout = 3;
              no_hardware_cursors = 2;
            };

            xwayland = {
              force_zero_scaling = true;
            };

            input = {
              kb_layout = "de";
              kb_options = "caps:swapescape";
              follow_mouse = 1;
              touchpad.natural_scroll = true;
              sensitivity = 0;
            };

            general = {
              allow_tearing = false;
              gaps_workspaces = 0;
              gaps_in = 0;
              gaps_out = 0;
              border_size = 2;
              layout = "dwindle";
              resize_on_border = true;
              col = {
                active_border = "rgba(bd93f9ff)";
                inactive_border = "rgba(6272a4ff)";
              };
            };

            decoration = {
              rounding = 0;
              rounding_power = 2;
              active_opacity = 1.0;
              inactive_opacity = 0.98;
              blur = {
                enabled = true;
                size = 3;
                passes = 2;
                vibrancy = 0.1696;
              };
              shadow = {
                enabled = false;
                range = 4;
                render_power = 3;
                color = "rgba(1a1a1aee)";
              };
            };

            dwindle = {
              preserve_split = true;
            };

            master = { };

            animations = {
              enabled = false;
            };

            misc = {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              focus_on_activate = true;
              vrr = 1;
            };
          };
        };

        extraConfig = /* lua */ ''
          hl.on("hyprland.start", function()
            hl.exec_cmd("${lib.getExe pkgs.waybar}")
            hl.exec_cmd("${lib.getExe pkgs.hyprpaper}")
            hl.exec_cmd("${lib.getExe' pkgs.wl-clipboard "wl-paste"} --watch ${lib.getExe pkgs.cliphist} store")
            hl.exec_cmd("${lib.getExe' pkgs.udiskie "udiskie"}")
            hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 24")
          end)

          hl.env("WLR_NO_HARDWARE_CURSORS", "1")
          hl.env("XCURSOR_THEME", "catppuccin-mocha-dark-cursors")
          hl.env("XCURSOR_SIZE", "24")
          hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

          hl.layer_rule({
            match        = { namespace = "^noctalia-background-.*$" },
            blur         = true,
            blur_popups  = true,
            ignore_alpha = 0.5,
          })

          ${mkHyprlandBinds}

          local mod = "SUPER"
          hl.bind(mod .. " + C",         hl.dsp.window.close())
          hl.bind(mod .. " + SHIFT + M", hl.dsp.exit())
          hl.bind(mod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mod .. " + P",         hl.dsp.window.pseudo())
          hl.bind(mod .. " + J",         hl.dsp.layout("togglesplit"))
          hl.bind(mod .. " + F",         hl.dsp.window.fullscreen({ mode = 0 }))
          hl.bind(mod .. " + H",         hl.dsp.focus({ direction = "left" }))
          hl.bind(mod .. " + L",         hl.dsp.focus({ direction = "right" }))
          hl.bind(mod .. " + K",         hl.dsp.focus({ direction = "up" }))
          hl.bind(mod .. " + J",         hl.dsp.focus({ direction = "down" }))
          for i = 1, 9 do
            hl.bind(mod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
            hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, silent = true }))
          end
          hl.bind(mod .. " + 0",          hl.dsp.focus({ workspace = 10 }))
          hl.bind(mod .. " + SHIFT + 0",  hl.dsp.window.move({ workspace = 10, silent = true }))
          hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
          hl.bind(mod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }))
          hl.bind(mod .. " + SHIFT + L",  hl.dsp.window.move({ direction = "right" }))
          hl.bind(mod .. " + SHIFT + K",  hl.dsp.window.move({ direction = "up" }))
          hl.bind(mod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))
          hl.bind(mod .. " + SHIFT + right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }))
          hl.bind(mod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }))
          hl.bind(mod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }))
          hl.bind(mod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }))
          hl.bind(mod .. " + code:123",      hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} volume 1"))
          hl.bind("XF86AudioRaiseVolume",    hl.dsp.exec_cmd("${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
          hl.bind("XF86AudioLowerVolume",    hl.dsp.exec_cmd("${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
          hl.bind("XF86AudioMute",           hl.dsp.exec_cmd("${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle"))
          hl.bind("XF86MonBrightnessUp",     hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} --class=backlight set +5%"))
          hl.bind("XF86MonBrightnessDown",   hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} --class=backlight set 5%-"))
          hl.bind("XF86AudioPlay",           hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} play-pause"))
          hl.bind("XF86AudioStop",           hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} stop"))
          hl.bind("XF86AudioNext",           hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} next"))
          hl.bind("XF86AudioPrev",           hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} previous"))
          hl.bind(mod .. " + mouse:272",     hl.dsp.window.drag(),   { mouse = true })
          hl.bind(mod .. " + mouse:273",     hl.dsp.window.resize(), { mouse = true })
          hl.bind(mod .. " + Super_L",       hl.dsp.exec_cmd("${lib.getExe pkgs.fuzzel}"), { release = true })
        '';
      };
    };
}

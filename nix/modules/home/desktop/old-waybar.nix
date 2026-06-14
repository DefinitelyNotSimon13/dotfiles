{ ... }:
{
  flake.modules.home.old-waybar = { pkgs, ... }: {

    stylix.targets.waybar.enable = false;

    programs.waybar = {
      enable = true;
      settings = {
        second-bar = {
          layer = "top";
          output = [
            "DP-7"
            "DP-2"
            "DP-3"
            "HDMI-A-1"
          ];
          position = "bottom";
          margin = "0 0";
          margin-bottom = 0;
          margin-top = 0;
          modules-right = [
          ];
          modules-left = [
            "clock"
            "hyprland/workspaces"
            "hyprland/window"
          ];
        };
        mainbar = {
          layer = "top";
          output = [
            "DP-6"
            "DP-1"
            "eDP-1"
          ];
          position = "bottom";
          margin = "0 0";
          margin-bottom = 0;
          margin-top = 0;
          modules-left = [
            "clock"
            "user#1"
            "custom/updates"
            "custom/media"
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [ ];
          modules-right = [
            "tray"
            "group/hardware"
            "pulseaudio"
            "network"
            "temperature"
            "memory"
            "battery"
            "backlight"
            "keyboard-state"
            "hyprland/language"
            "custom/power"
          ];

          "keyboard-state" = {
            numlock = true;
            capslock = false;
            format = "{icon} {name}";
            format-icons = {
              "locked" = "";
              "unlocked" = "";
            };
            on-click = "eww open dropdown";
            on-click-right = "eww close dropdown";
          };
          "custom/updates" = {
            format = " {}";
            tooltip = false;
            interval = 3600;
            exec = "exec $HOME/.config/waybar/scripts/checkupdate.sh";
            onclick = "kitty --hold pacman -Qu";
          };
          "custom/media" = {
            format = "{icon} {}";
            returntype = "json";
            max-length = 40;
            format-icons = {
              "spotify" = "";
              "default" = "󰎈";
            };
            escape = true;
            exec = "$HOME/.config/waybar/scripts/mediaplayer.py 2> /dev/null";
            onclick = "$HOME/.bin/mpd";
          };
          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "urgent" = "";
              "default" = "-";
            };
            sort-by-number = true;
          };
          "hyprland/window" = {
            format = "➡ {}";
            separate-outputs = true;
          };
          "clock" = {
            tooltip-format = "<big>{=%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{=%Y-%m-%d}";
          };
          "cpu" = {
            format = " {usage}%";
            tooltip = false;
          };
          "memory" = {
            format = "{}% ";
          };
          "temperature" = {
            thermal-zone = 1;
            critical-threshold = 80;
            format-critical = "{temperatureC}°C {icon}";
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
            ];
          };
          "battery" = {
            states = {
              "good" = 95;
              "warning" = 30;
              "critical" = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = [
              "󰁺"
              "󰁼"
              "󰁿"
              "󰂁"
              "󰁹"
            ];
            on-click = "$HOME/.bin/battery";
          };
          "network" = {
            format-wifi = "  {essid} ({signalStrength}%)";
            format-ethernet = " 󰈀 Connected";
            tooltip-format = "󰙨 {ifname} via {gwaddr}";
            format-linked = "󰙨 {ifname} (No IP)";
            format-disconnected = "⚠ Disconnected";
            format-alt = "{ifname}= {ipaddr}/{cidr}";
            on-click = "nm-applet";
          };
          "pulseaudio" = {
            format = "{icon}  {volume}%";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "" # " {volume}%"
            ;
            format-source-muted = "";
            reverse-scrolling = true;
            format-icons = {
              "headphone" = "";
              "hands-free" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = [
                ""
                ""
                ""
              ];
            };
            on-click = "$HOME/.bin/volume";
          };
          "user#1" = {
            format = " {user}";
            interval = 60;
            height = 30;
            width = 30;
            icon = true;
          };
          "custom/power" = {
            format = "⏻";
            tooltip = true;
            tooltip-format = "Powermenu";
            on-click = "$HOME/.bin/powermenu";
          };
          "tray" = {
            show-passive-items = true;
            icon-size = 12;
            spacing = 8;
          };
          "backlight" = {
            format = "{icon} {percent}%";
            format-icons = [ "󰃞" ];
            on-click = "$HOME/.bin/brightness";
          };
          "hyprland/language" = {
            format = "{}";
            format-en = "AMERICA, FUCK YEAH!";
            format-de = "de";
            keyboard-name = "at-translated-set-2-keyboard";
          };
          "disk" = {
            format = "  {free} / {total}";
            interval = 30;
          };
          "group/hardware" = {
            orientation = "horizontal";
            click-to-reveal = true;
            drawer = {
              transition-duration = 500;
              children-class = "not-power";
              transition-left-to-right = false;
            };
            modules = [
              "custom/hardware-group"
              "disk"
              "cpu"
            ];
          };
          "custom/hardware-group" = {
            format = "󰇅 ";
            tooltip = false;
          };
        };
      };
      style = /* css */ ''
        @define-color background   #282a36;
        @define-color current-line #44475a;
        @define-color foreground   #f8f8f2;
        @define-color comment      #6272a4;
        @define-color cyan         #8be9fd;
        @define-color green        #50fa7b;
        @define-color orange       #ffb86c;
        @define-color pink         #ff79c6;
        @define-color purple       #bd93f9;
        @define-color red          #ff5555;
        @define-color yellow       #f1fa8c;


        * {
        font-family: JetBrains Mono Nerd Font;
        font-size: 14px;
        }

        window#waybar {
        background-color: @background;
        color: @foreground;
        transition-property: background-color;
        transition-duration: 0s;
        }

        window#waybar.hidden {
        opacity: 0.2;
        }


        window#waybar.termite {
        }

        window#waybar.chromium {
        border: none;
        }

        button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
        }

        #workspaces button {
        padding: 0 5px;
        color: @orange;
        margin: 2px;
        font-weight: bold;
        }

        #workspaces button.active {
        background-color: @orange;
        color: @background;
        }
        #workspaces button:hover {
        background-color: @orange;
        color: @background;
        }
        #workspaces button.active:hover {
        color: @orange;
        }
        #workspaces button.hidden {
        color: @pink;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #temperature,
        #network,
        #hardware,
        #hardware-group,
        #disk
        #language,
        #pulseaudio,
        #keyboard-state,
        #mpd,
        #backlight {
        padding: 0 8px;
        color: @orange;
        font-weight: bold;
        }

        #language,
        #network {
        color: @cyan;
        }

        #backlight {
        color: @green;
        }


        #hardware-group,
        #memory {
        color: @yellow;
        }

        #custom-power {
        color: @red;
        font-weight: bold;
        padding: 0 15px;
        margin: 0 5px;
        }

        #user,
        #window,
        #workspaces,
        #custom-updates,
        #custom-media {
        margin: 0 4px;
        background-color: transparent;
        font-weight: bold;
        padding: 0 10px;
        color: @orange;
        }

        #user,
        #window,
        #custom-updates {
        }

        #disk,
        #user {
        color: @green;
        }

        #user.1 {
        margin-right: 0;
        padding-right: 5px;
        }

        #custom-updates {
        margin-left: 0;
        padding-left: 5px;
        color: @cyan;
        }

        #custom-media {
        min-width: 100px;
        color: @purple;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
        }

        #clock {
        color: @cyan;
        }

        @keyframes blink {
        to {
        background-color: #ffffff;
        color: #000000;
        }
        }

        label:focus {
        }

        #network.disconnected {
        background-color: @red;
        }

        #pulseaudio {
        padding-right: 0;
        color: @pink;
        }

        #pulseaudio.muted {
        background-color: @comment;
        color: @foreground;
        }

        #temperature.critical {
        background-color: @red;
        }

        #temperature {
        color: @green;
        }

        #keyboard-state {
        padding: 0 0px;
        min-width: 16px;
        color: @purple;
        }

        #keyboard-state > label {
        padding: 0 5px;
        }

        #tray {
        padding: 0 10px;
        margin: 0 5px;
        }

        #tray.empty {
        background-color: transparent;
        }
      '';
    };
  };
}

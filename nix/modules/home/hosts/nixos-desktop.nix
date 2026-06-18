{ lib, ... }:
{
  flake.modules.home.nixos-desktop =
    { pkgs, lib, ... }:
    {
      preferences.monitors = {
        "DP-1" = {
          width = 2560;
          height = 1440;
          refreshRate = 164.84;
          x = 1920;
          primary = true;
        };
        "HDMI-A-1" = {
          width = 1920;
          height = 1080;
        };
        "DP-3" = {
          width = 1920;
          height = 1080;
          x = 4480;
          y = -700;
          transform = 3;
        };
      };

      preferences.keybinds = [
        {
          key = "RETURN";
          exec = "${lib.getExe pkgs.ghostty} +new-window";
        }
        {
          key = "SPACE";
          exec = lib.getExe pkgs.fuzzel;
        }
        {
          key = "Q";
          exec = lib.getExe pkgs.brave;
        }
        {
          key = "S";
          exec = "${lib.getExe pkgs.hyprshot} -m region";
        }
        {
          mods = "SUPER + SHIFT";
          key = "S";
          exec = lib.getExe pkgs.spotify;
        }
        {
          mods = "SUPER + SHIFT";
          key = "V";
          exec = "qs -c noctalia-shell ipc call launcher clipboard";
        }
        {
          mods = "SUPER + SHIFT";
          key = "E";
          exec = "qs -c noctalia-shell ipc call launcher emoji";
        }
        {
          mods = "SUPER + SHIFT";
          key = "P";
          exec = "qs -c noctalia-shell ipc call sessionMenu toggle";
        }
        {
          key = "comma";
          exec = "qs -c noctalia-shell ipc call settings toggle";
        }
      ];
    };
}

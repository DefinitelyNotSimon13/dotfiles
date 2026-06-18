{ config, ... }:
let
  hm = config.flake.modules.home;
in
{
  flake.modules.nixos.nixos-desktop =
    {
      inputs,
      self,
      pkgs,
      lib,
      ...
    }:
    {
      networking.hostName = "nixos-desktop";
      system.stateVersion = "26.05";

      programs.nh.flake = "/home/simon/.dotfiles/nix";
      programs.nix-index-database.comma.enable = true;

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs self; };
      home-manager.users.simon = hm.simon;

      programs.corectrl.enable = true;

      hardware.cpu.amd.updateMicrocode = true;
      hardware.graphics.enable = true;
      powerManagement.cpuFreqGovernor = "schedutil";

      services = {
        hardware.openrgb.enable = true;
        flatpak.enable = true;
        udisks2.enable = true;
      };

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

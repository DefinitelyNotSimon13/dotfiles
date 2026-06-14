{ config, ... }:
let
  hm = config.flake.modules.home;
in
{
  flake.modules.nixos.nixos-desktop = { inputs, ... }: {

    networking.hostName = "nixos-desktop";
    system.stateVersion = "26.05";

    programs.nh.flake = "/home/simon/.dotfiles/nix";
    programs.nix-index-database.comma.enable = true;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };
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
  };
}

{
  config,
  inputs,
  self,
  ...
}:
let
  hw = config.flake.modules.hardware;
  mod = config.flake.modules.nixos;
in
{
  flake.nixosConfigurations.nixos-desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };

    modules = [
      hw.nixos-desktop
      mod.nixos-desktop

      mod.nix
      mod.locale
      mod.networking
      mod.ssh

      mod.boot
      mod.grub
      mod.plymouth

      mod.fonts
      mod.gnome
      mod.audio
      mod.stylix
      mod.virtualization

      mod.sops

      mod.simon

      mod.gaming

      mod.hyprland
      mod.niri

      inputs.home-manager.nixosModules.home-manager
      inputs.nix-index-database.nixosModules.default
    ];
  };
}

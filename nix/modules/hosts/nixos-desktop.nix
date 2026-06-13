{
  config,
  inputs,
  ...
}:
let
  mod = config.flake.modules.nixos;
  hm = config.flake.modules.home;
in
{
  flake.nixosConfigurations.nixos-desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };

    modules = [
      ../../hardware/nixos-desktop/hardware-configuration.nix

      mod.nix
      mod.locale
      mod.networking
      mod.ssh

      mod.grub
      mod.plymouth

      mod.fonts
      mod.gnome
      mod.audio
      mod.stylix

      mod.sops

      mod.simon

      inputs.home-manager.nixosModules.home-manager

      {
        networking.hostName = "nixos-desktop";
        system.stateVersion = "26.05";

        programs.nh.flake = "/home/simon/.dotfiles/nix";

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.simon = hm.simon;
      }
    ];
  };
}

{ ... }:
{
  flake.modules.nixos.hyprland = { pkgs, ... }: {
    programs.hyprland.enable = true;

    environment.systemPackages = [
      pkgs.kitty
    ];
  };
}

{ ... }:
{
  flake.modules.nixos.gnome = { ... }: {
    services.xserver.enable = true;
    services.displayManager = {
      defaultSession = "hyprland";
    };
    services.displayManager.gdm = {
      enable = true;
    };
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb.options = "caps:swapescape";

    services.printing.enable = true;

    programs.firefox.enable = true;
  };
}

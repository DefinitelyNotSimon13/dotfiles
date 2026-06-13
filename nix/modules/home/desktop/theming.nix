{ ... }:
{
  flake.modules.home.theming =
    {
      pkgs,
      ...
    }:
    {

      stylix.targets.firefox.profileNames = [ "default" ];

      home.packages = with pkgs; [
        gnome-tweaks
        dconf-editor
      ];
    };
}

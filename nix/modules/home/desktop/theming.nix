{ ... }:
{
  flake.modules.home.theming =
    {
      pkgs,
      ...
    }:
    {

      stylix.targets.firefox.profileNames = [ "default" ];

      gtk = {
        enable = true;
        gtk3.extraConfig = {
          "gtk-xft-dpi" = 98304; # 96 * 1024
        };

        gtk4.extraConfig = {
          "gtk-xft-dpi" = 98304; # 96 * 1024
        };

      };

      home.packages = with pkgs; [
        gnome-tweaks
        dconf-editor
      ];
    };
}

{ ... }:
{
  flake.modules.nixos.stylix =
    {
      inputs,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
        # image = pkgs.runCommand "dracula-wallpaper.png" {
        #   nativeBuildInputs = [ pkgs.imagemagick ];
        # } "convert -size 1920x1080 xc:#282a36 $out";
        polarity = "dark";
        targets = {
          qt.platform = lib.mkForce "qtct";
        };
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };
    };
}

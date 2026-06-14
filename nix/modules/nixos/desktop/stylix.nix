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
        image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dracula/wallpaper/master/first-collection/nixos.png";
          hash = "sha256-hJBs+1MYSAqxb9+ENP0AsHdUrvjTzjobGv57dx5pPGE=";
        };
        polarity = "dark";
        targets = {
          qt.platform = lib.mkForce "qtct";
        };
      };
    };
}

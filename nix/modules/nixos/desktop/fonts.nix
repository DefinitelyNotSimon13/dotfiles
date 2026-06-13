{ ... }:
{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        cantarell-fonts
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [
            "JetBrainsMono Nerd Font"
            "Noto Sans Mono"
          ];
          sansSerif = [
            "Cantarell"
            "Noto Sans"
          ];
          serif = [ "Noto Serif" ];
          emoji = [ "Noto Color Emoji" ];
        };
        antialias = true;
        hinting.enable = true;
        hinting.style = "slight";
        subpixel.rgba = "rgb";
      };
    };
  };
}

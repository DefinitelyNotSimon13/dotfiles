{ ... }:
{
  flake.modules.home.base = { pkgs, ... }: {
    programs.home-manager.enable = true;
    xdg.enable = true;

    home.packages = with pkgs; [
      zip
      wakatime-cli
      wl-clipboard
    ];

  };
}

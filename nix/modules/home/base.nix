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

    programs.btop.enable = true;

    home.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    programs.zsh.shellAliases = {
      nr = "nix run --impure";
      ns = "nix shell --impure";
    };

  };
}

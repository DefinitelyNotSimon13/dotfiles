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

    programs.ghostty.enable = true;

    programs.btop.enable = true;
    stylix.targets.ghostty.enable = false;

    home.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    programs.zsh.shellAliases = {
      nr = "nix run --impure";
      ns = "nix shell --impure";
    };

  };
}

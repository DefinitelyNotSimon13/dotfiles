{ ... }:
{
  flake.modules.home.apps = { pkgs, ... }: {
    home.packages = with pkgs; [
      ghostty      # GPU-accelerated terminal (config lives in dotfiles → ~/.config/ghostty)
      zed-editor   # modern code editor
    ];
  };
}

{ ... }:
{
  flake.modules.home.apps = { pkgs, ... }: {
    home.packages = with pkgs; [
      zed-editor
    ];
  };
}

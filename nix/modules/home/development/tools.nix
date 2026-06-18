{ ... }:
{
  flake.modules.home.tools = { pkgs, ... }: {

    programs.bat = {
      enable = true;
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--height=40%"
        "--layout=reverse"
        "--border"
      ];
      tmux.enableShellIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.lazygit.enable = true;
    programs.fd.enable = true;
    programs.ripgrep.enable = true;
    programs.jq.enable = true;

    home.packages = with pkgs; [
      tealdeer
      just
      xh
      curl
      unzip
    ];
  };
}

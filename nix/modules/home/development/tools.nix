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
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # direnv with nix-direnv: fast `use flake` support for devenv shells
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.lazygit.enable = true;

    # Packages without a dedicated HM programs.* module
    home.packages = with pkgs; [
      ripgrep
      fd
      jq
      curl
      unzip
    ];
  };
}

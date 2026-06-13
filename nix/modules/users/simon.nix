# Both the NixOS user account and Simon's Home Manager configuration live here.
{ config, ... }:
let
  hm = config.flake.modules.home;
in
{
  flake.modules.nixos.simon = { pkgs, ... }: {
    programs.zsh.enable = true;

    users.users.simon = {
      isNormalUser = true;
      description = "Simon Blum";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
    };
  };

  flake.modules.home.simon = { ... }: {
    imports = [
      hm.base
      hm.zsh
      hm.tmux
      hm.dotfiles
      hm.neovim
      hm.tools
      hm.git
      hm.devenv
      hm.sops
      hm.theming
      hm.apps
      hm.firefox
    ];

    home.username = "simon";
    home.homeDirectory = "/home/simon";
    home.stateVersion = "26.05";
  };
}

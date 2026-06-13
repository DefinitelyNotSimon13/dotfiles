{ ... }:
{
  flake.modules.home.dotfiles =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      dotfiles = "${config.home.homeDirectory}/.dotfiles";
      link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
    in
    {
      # stubbed
      home.activation.cloneDotfiles = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
        if [ ! -d "${dotfiles}" ]; then
          run ${pkgs.git}/bin/git clone https://github.com/DefinitelyNotSimon13/dotfiles.git "${dotfiles}"
        fi
      '';

      xdg.configFile = {
        "nvim".source = link "nvim/dot-config/nvim";
        "ghostty".source = link "ghostty/dot-config/ghostty";
        "zsh/conf.d".source = link "zsh/dot-config/conf.d";
      };
    };
}

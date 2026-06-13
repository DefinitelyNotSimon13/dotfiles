{ ... }:
{
  flake.modules.home.zsh = { lib, ... }: {
    programs.zsh = {
      enable = true;

      initContent = /* zsh */ ''
        for f in "''${ZDOTDIR:-$HOME/.config/zsh}"/conf.d/*.zsh; do
          source "$f"
        done
      '';
    };
  };
}

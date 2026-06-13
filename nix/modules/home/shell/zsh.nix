{ ... }:
{
  flake.modules.home.zsh =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      programs.zsh = {
        enable = true;

        completionInit = "autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump";
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;

        initContent = lib.mkBefore /* zsh */ ''
          ZVM_INIT_MODE=sourcing
          for f in "''${ZDOTDIR:-$HOME/.config/zsh}"/conf.d/*.zsh; do
            source "$f"
          done

          zvm_after_init() {
            _bindings_init
          }
        '';
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = false;
        configPath = "${config.xdg.configHome}/starship/starship.toml";
      };

      stylix.targets.starship.enable = false;
    };
}

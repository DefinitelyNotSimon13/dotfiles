{ ... }:
{
  flake.modules.home.git = { pkgs, ... }: {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      settings = {
        user.name = "Simon Blum";
        user.email = "simon21.blum@gmail.com";

        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase.autoStash = true;
        merge.conflictstyle = "zdiff3";
        diff.algorithm = "histogram";
        core.autocrlf = "input";

        url."git@github.com:".insteadOf = "https://github.com/";
      };

      ignores = [
        ".direnv"
        ".devenv"
        "*.DS_Store"
        "CLAUDE.md"
        "AGENTS.md"
        ".claude"
        ".codex"
      ];
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        dark = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "gruvbox-dark";
      };
    };

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
      gitCredentialHelper.enable = true;
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}

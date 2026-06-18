{
  self,
  ...
}:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.myGhostty = pkgs.symlinkJoin {
        name = "ghostty";
        paths = [ pkgs.ghostty ];

        nativeBuildInputs = [ pkgs.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/ghostty \
            --set GTK_IM_MODULE simple
        '';

        meta = pkgs.ghostty.meta // {
          mainProgram = "ghostty";
        };
      };
    };

  flake.modules.home.ghostty =
    {
      pkgs,
      lib,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      ghostty = self.packages.${system}.myGhostty;
    in
    {
      stylix.targets.ghostty.enable = false;

      programs.ghostty = {
        enable = true;
        package = ghostty;

        systemd.enable = true;

        enableZshIntegration = true;
        installBatSyntax = true;
        installVimSyntax = true;

        settings = {
          font-size = 12;
          font-feature = [
            "+calt"
            "+liga"
            "+dlig"
            "+zero"

            "+ss02"
            "+ss19"
            "+ss20"

            "+cv02"
            "+cv04"
            "+cv05"
            "+cv17"
          ];

          font-family = "JetBrainsMono Nerd Font";

          shell-integration-features = [
            "ssh-env"
            "ssh-terminfo"
            "cursor"
            "sudo"
            "title"
          ];

          shell-integration = "zsh";

          clipboard-read = "allow";
          clipboard-write = "allow";

          theme = "Dracula";
          window-padding-x = 12;
          window-padding-y = 12;
          background-opacity = 1.0;
          background-blur-radius = 32;

          cursor-style = "block";
          cursor-style-blink = true;

          scrollback-limit = 3023;

          mouse-hide-while-typing = true;

          quit-after-last-window-closed = false;

          gtk-titlebar = false;
          confirm-close-surface = false;
        };
      };

      home.sessionVariables = {
        TERMINAL = "${lib.getExe ghostty} +new-window";
        GTK_IM_MODULE = "simple";
      };

      systemd.user.sessionVariables = {
        GTK_IM_MODULE = "simple";
      };
    };
}

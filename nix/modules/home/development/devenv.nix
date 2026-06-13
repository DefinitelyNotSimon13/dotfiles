{ ... }:
{
  flake.modules.home.devenv = { pkgs, inputs, ... }: {
    home.packages = [
      inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.devenv
    ];

    # Cachix cache for devenv pre-built binaries — optional but speeds up devenv init
    # nix.settings.extra-substituters = [ "https://devenv.cachix.org" ];
    # nix.settings.extra-trusted-public-keys = [
    #   "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    # ];
  };
}

{ ... }:
{
  flake.modules.nixos.nix =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    {
      sops.secrets.nix-access-tokens = {
        mode = "0400";
        owner = "root";
      };

      nix.extraOptions = ''
        !include ${config.sops.secrets.nix-access-tokens.path}
      '';
      nixpkgs.overlays = [
        (_final: prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (prev) system;
            config.allowUnfree = true;
          };
        })
        inputs.nur.overlays.default
      ];

      environment.systemPackages = with pkgs; [
        gitFull
        openssh
      ];

      nix.settings = {
        max-jobs = "auto";
        cores = 0;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
        trusted-users = [
          "root"
          "@wheel"
        ];
      };

      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 7d --keep 5";
        };
      };

      nixpkgs.config.allowUnfree = true;

      programs.nix-ld.enable = true;
    };
}

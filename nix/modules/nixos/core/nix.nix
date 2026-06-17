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
        inputs.nix-cachyos-kernel.overlays.pinned
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
        substituters = [
          "https://attic.xuyh0120.win/lantian"
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

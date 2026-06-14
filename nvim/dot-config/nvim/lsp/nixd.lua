return {
  cmd = { 'nixd' },
  root_markers = { 'flake.nix', '.git', 'devenv.nix' },

  settings = {
    nixd = {
      nixpkgs = {
        expr = [[
          let
            flake = builtins.getFlake "github:DefinitelyNotSimon13/dotfiles?dir=nix"
            system = builtins.currentSystem;
          in
            import flake.inputs.nixpkgs {
              inherit system;

              config.allowUnfree = true;

              overlays = [
                (_final: prev: {
                  unstable = import flake.inputs.nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                })

                flake.inputs.nur.overlays.default
              ];
            }
        ]],
      },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        nixos = {
          expr = [[
            (builtins.getFlake "github:DefinitelyNotSimon13/dotfiles?dir=nix").nixosConfigurations.nixos-desktop.options
          ]],
        },
        home_manager = {
          expr = [[
            (builtins.getFlake "github:DefinitelyNotSimon13/dotfiles?dir=nix").nixosConfigurations.nixos-desktop.options.home-manager.users.type.getSubOptions []
          ]],
        },
      },
    },
  },
}

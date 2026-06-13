return {
  cmd = { 'nixd' },
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import (builtins.getFlake(toString ./.)).inputs.nixpkgs { }',
      },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake "github:DefinitelyNotSimon13/nixos-config-flake").nixosConfigurations.nixos-desktop.options',
        },
        home_manager = {
          expr = '(builtins.getFlake "github:DefinitelyNotSimon13/nixos-config-flake").homeConfigurations.simon-arch@arch-desktop.options',
        },
      },
    },
  },
}

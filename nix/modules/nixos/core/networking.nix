{ ... }:
{
  flake.modules.nixos.networking = { ... }: {
    networking.networkmanager.enable = true;
    # networking.hostName is set per-host in modules/hosts/<name>.nix
  };
}

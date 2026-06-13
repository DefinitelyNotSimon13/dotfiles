# Declares the custom flake-parts options used by the dendritic pattern.
# Each NixOS/HM feature module sets flake.modules.nixos.<name> or flake.modules.home.<name>
# to a module function. Host and user definitions then compose from these named modules.
{ lib, ... }:
{
  options.flake.modules = {
    nixos = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = { };
      description = "NixOS feature modules keyed by name, composed by host definitions.";
    };
    home = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = { };
      description = "Home Manager feature modules keyed by name, composed by user definitions.";
    };
  };
}

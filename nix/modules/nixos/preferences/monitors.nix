{ lib, ... }:
{
  flake.modules.nixos.preferences-monitors =
    { lib, ... }:
    {
      options.preferences.monitors = lib.mkOption {
        default = { };
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            width = lib.mkOption { type = lib.types.int; };
            height = lib.mkOption { type = lib.types.int; };
            refreshRate = lib.mkOption {
              type = lib.types.float;
              default = 60.0;
            };
            x = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            y = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            scale = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
            };
            transform = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            primary = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };
          };
        });
      };
    };
}

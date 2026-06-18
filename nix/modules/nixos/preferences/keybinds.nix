{ lib, ... }:
{
  flake.modules.nixos.preferences-keybinds =
    { lib, ... }:
    {
      options.preferences.keybinds = lib.mkOption {
        default = [ ];
        type = lib.types.listOf (lib.types.submodule {
          options = {
            mods = lib.mkOption {
              type = lib.types.str;
              default = "SUPER";
            };
            key = lib.mkOption { type = lib.types.str; };
            exec = lib.mkOption { type = lib.types.str; };
          };
        });
      };
    };
}

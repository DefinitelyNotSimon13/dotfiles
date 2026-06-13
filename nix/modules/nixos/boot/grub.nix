{ ... }:
{
  flake.modules.nixos.grub = { lib, pkgs, ... }: {
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.grub = {
      enable        = true;
      efiSupport    = true;
      device        = "nodev";
      useOSProber   = true;   # Detects Windows on other partitions
      configurationLimit = 10;

      # Uncomment and set a theme derivation to customise the look, e.g.:
      # theme = pkgs.fetchFromGitHub {
      #   owner  = "vinceliuice";
      #   repo   = "grub2-themes";
      #   rev    = "<commit>";
      #   sha256 = "<hash>";
      # } + "/vimix";
    };
  };
}

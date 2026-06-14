{ ... }:
{
  flake.modules.nixos.grub = { lib, pkgs, ... }: {
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      configurationLimit = 10;

      gfxmodeEfi = "1920x1080";
      gfxpayloadEfi = "keep";

    };
  };
}

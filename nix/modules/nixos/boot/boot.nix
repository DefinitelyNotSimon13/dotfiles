{ ... }:
{
  flake.modules.nixos.boot = { pkgs, config, ... }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = [
        "video=DP-1:2560x1440@165e"
        "video=DP-3:1920x1080@60e"
        "video=HDMI-A-1:1920x1080@60e"
      ];

      initrd.kernelModules = [
        "amdgpu"
      ];

      kernelModules = [
        "k10temp"
        "kvm-amd"
      ];

      supportedFilesystems.ntfs = true;
      binfmt.emulatedSystems = [ "aarch64-linux" ];
    };
  };
}

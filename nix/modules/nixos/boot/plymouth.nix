{ ... }:
{
  flake.modules.nixos.plymouth = { ... }: {
    boot.plymouth = {
      enable = true;
    };

    boot.initrd.systemd.enable = true;

    boot.kernelParams = [
      "quiet"
      "splash"
    ];

    boot.consoleLogLevel = 3;
  };
}

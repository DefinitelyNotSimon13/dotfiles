{ ... }:
{
  flake.modules.nixos.audio = { pkgs, ... }: {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;

      jack.enable = true;

      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pwvucontrol

      # PipeWire graph / routing
      qpwgraph
      crosspipe

      # EQ, compressor, limiter, noise reduction, etc.
      easyeffects

      # CLI control / scripts / keybinds
      pamixer
      playerctl
    ];

    services.goxlr-utility = {
      enable = true;
      autoStart.xdg = true;
    };
  };
}

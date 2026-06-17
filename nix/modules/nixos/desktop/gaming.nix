{ ... }:
{
  flake.modules.nixos.gaming =
    { pkgs, lib, ... }:
    let
      gamingBase = {
        programs.steam = {
          enable = true;
          remotePlay.openFirewall = true;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };

        boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest;

        services.xserver.xkb = {
          layout = "de";
          variant = "";
          options = "caps:swapescape";
        };

        environment.sessionVariables = {
          XKB_DEFAULT_LAYOUT = "de";
          XKB_DEFAULT_OPTIONS = "caps:swapescape";
        };

        programs.gamemode.enable = true;
        programs.gamescope.enable = true;

        hardware.graphics.enable32Bit = true;

        environment.systemPackages = with pkgs; [
          mangohud
          protonup-qt
          lutris
          heroic
          winetricks
        ];
      };
    in
    {
      specialisation.gaming-desktop.configuration = lib.mkMerge [
        gamingBase
        {
          system.nixos.tags = [ "gaming-desktop" ];
          programs.steam.gamescopeSession.enable = false;
        }
      ];

      specialisation.gaming-steam-bp.configuration = lib.mkMerge [
        gamingBase
        {
          system.nixos.tags = [ "gaming-steam-bp" ];
          boot.kernelParams = [
            "video=DP-1:2560x1440@165e"
            "video=DP-3:d"
            "video=HDMI-A-1:d"
          ];

          services.displayManager = {
            defaultSession = lib.mkForce "steam";

            autoLogin = {
              enable = true;
              user = "simon";
            };
          };

          programs.steam.gamescopeSession = {
            enable = true;

          };
        }
      ];
    };
}

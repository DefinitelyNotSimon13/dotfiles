{ self, inputs, ... }:
{
  perSystem =
    { pkgs, lib, ... }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          input = {
            keyboard.xkb = {
              layout = "de";
              options = "caps:swapescape";
            };
          };

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          layout.gaps = 5;

          spawn-sh-at-startup = [
            "${lib.getExe pkgs.waybar}"
            "wl-paste --watch ${lib.getExe pkgs.cliphist} store"
          ];

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+Space".spawn-sh = lib.getExe pkgs.fuzzel;
            "Mod+C".close-window = _: { };
            "Mod+Shift+M".quit = _: { };
            "Mod+F".maximize-column = _: { };

            "Mod+H".focus-column-left = _: { };
            "Mod+L".focus-column-right = _: { };
            "Mod+J".focus-window-down = _: { };
            "Mod+K".focus-window-up = _: { };

            "Mod+Shift+H".move-column-left = _: { };
            "Mod+Shift+L".move-column-right = _: { };
            "Mod+Shift+J".move-window-down = _: { };
            "Mod+Shift+K".move-window-up = _: { };

            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;

            "Mod+Shift+1".move-window-to-workspace = 1;
            "Mod+Shift+2".move-window-to-workspace = 2;
            "Mod+Shift+3".move-window-to-workspace = 3;
            "Mod+Shift+4".move-window-to-workspace = 4;
            "Mod+Shift+5".move-window-to-workspace = 5;
            "Mod+Shift+6".move-window-to-workspace = 6;
            "Mod+Shift+7".move-window-to-workspace = 7;
            "Mod+Shift+8".move-window-to-workspace = 8;
            "Mod+Shift+9".move-window-to-workspace = 9;

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioPlay".spawn-sh = "playerctl play-pause";
            "XF86AudioStop".spawn-sh = "playerctl stop";
            "XF86AudioNext".spawn-sh = "playerctl next";
            "XF86AudioPrev".spawn-sh = "playerctl previous";
          };
        };
      };
    };

  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };
}

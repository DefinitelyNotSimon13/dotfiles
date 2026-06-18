{ lib, ... }: {
  flake.preferenceLib = {
    mkMonitorSettings =
      monitors:
      lib.mapAttrsToList (
        name: m:
        {
          output = name;
          mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
          position = "${toString m.x}x${toString m.y}";
          scale = m.scale;
        }
        // lib.optionalAttrs (m.transform != 0) { transform = m.transform; }
      ) monitors;

    mkWorkspaceRules =
      monitors: n:
      let
        primary = lib.findFirst (m: m.primary) (throw "preferences.monitors: no monitor has primary = true") (
          lib.mapAttrsToList (name: m: m // { inherit name; }) monitors
        );
      in
      map (i: {
        workspace = toString i;
        monitor = primary.name;
        default = i == 1;
      }) (lib.range 1 n);

    mkPrimaryOutputs =
      monitors: lib.mapAttrsToList (n: _: n) (lib.filterAttrs (_: m: m.primary) monitors);

    mkSecondaryOutputs =
      monitors: lib.mapAttrsToList (n: _: n) (lib.filterAttrs (_: m: !m.primary) monitors);

    mkHyprlandBinds =
      keybinds:
      lib.concatMapStringsSep "\n" (
        b: ''hl.bind("${b.mods} + ${b.key}", hl.dsp.exec_cmd("${b.exec}"))''
      ) keybinds;
  };
}

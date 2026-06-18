{ ... }:
{
  flake.modules.home.packages = { pkgs, ... }: {

    programs.btop.enable = true;
    services.cliphist.enable = true;

    home.packages = with pkgs; [
      zip
      wakatime-cli
      procs
      dysk
    ];
  };
}

{ ... }:
{
  flake.modules.home.sops = { inputs, config, ... }: {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];

    sops = {
      defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";

      # User-level age key — generate with:
      #   age-keygen -o ~/.config/sops/age/keys.txt
      # Then add the public key to .sops.yaml
      age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    };
  };
}

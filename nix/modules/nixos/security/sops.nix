{ ... }:
{
  flake.modules.nixos.sops = { inputs, pkgs, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      # Path to the encrypted secrets file in the flake repo.
      # `inputs.self` resolves to the flake root in the Nix store.
      defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";

      # Decrypt using the host's SSH ED25519 key (converted to age internally).
      # Run `sudo ssh-to-age < /etc/ssh/ssh_host_ed25519_key.pub` to get the age pubkey
      # and add it to .sops.yaml before encrypting secrets.
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    environment.systemPackages = with pkgs; [
      sops
      age
    ];
  };
}

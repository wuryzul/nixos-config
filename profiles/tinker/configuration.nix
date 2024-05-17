{ systemSettings, pkgs, ... }: {
  imports = [
    ../homelab/configuration.nix
    ../../system/app/docker.nix
  ];

  config = {
    
  };
}
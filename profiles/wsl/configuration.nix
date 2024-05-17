{ systemSettings, pkgs, ... }: {
  imports = [
    ../base/configuration.nix
    ../../system/hardware/wsl.nix
    ../../system/app/docker.nix
  ];

  config = {
    
  };
}
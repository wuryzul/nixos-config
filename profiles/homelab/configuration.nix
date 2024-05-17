{ systemSettings, pkgs, ... }: {
  imports = [
    ../base/configuration.nix
    ../../system/hardware/qemu.nix
  ];

  config = {
    
  };
}
{ systemSettings, pkgs, ... }: {
  imports = [
    ../base/configuration.nix
    ../../system/hardware/qemu.nix
    ../../system/hardware/automount.nix
    ../../system/hardware/kernel.nix
    ../../system/hardware/time.nix
    ../../system/security/gpg.nix
  ];

  config = {
    
  };
}
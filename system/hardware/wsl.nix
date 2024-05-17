{ systemSettings, nixos-wsl, ... }: {
  imports = [
    ../app/docker.nix
  ];
  
  nixpkgs.hostPlatform = systemSettings.system;
  
  wsl.enable = true;
  wsl.defaultUser = "wury";
  wsl.wslConf.network.generateResolvConf = false;

  networking.nameservers = [
    "10.160.0.101"
    "10.160.0.100"
    "10.32.0.101"
    "10.32.0.100"
    "192.168.1.254"
    "1.1.1.1"
  ];
}
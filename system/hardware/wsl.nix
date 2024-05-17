{ systemSettings, ... }: {
  imports = [
    ../app/docker.nix
  ];
  
  nixpkgs.hostPlatform = systemSettings.system;
  
  wsl.enable = true;
  wsl.defaultUser = "wury";
  wsl.wslConf.network.generateResolvConf = false;  
}
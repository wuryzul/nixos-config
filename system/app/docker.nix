{ userSettings, config, libs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation.docker.enable = true;

  users.users."${userSettings.username}".extraGroups = [ "docker" ];

  networking.firewall.enable = false;
}

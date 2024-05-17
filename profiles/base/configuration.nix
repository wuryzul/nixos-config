{ systemSettings, userSettings, lib, pkgs, ... }: {
  imports = [
    ../../system/hardware-configuration.nix
    ../../system/hardware/automount.nix
    ../../system/hardware/kernel.nix
    ../../system/hardware/time.nix
    ../../system/security/gpg.nix
    ../../system/app/vscode.nix
  ];

  config = {
    nix.package = pkgs.nixFlakes;
    nix.settings.experimental-features = [ "nix-command flakes" ];

    nix.nixPath = [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=$HOME/dotfiles/system/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    networking = {
      networkmanager.enable = true;
      hostName = systemSettings.hostname;
    };

    time.timeZone = systemSettings.timezone;

    i18n.defaultLocale = systemSettings.locale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = systemSettings.locale;
      LC_IDENTIFICATION = systemSettings.locale;
      LC_MEASUREMENT = systemSettings.locale;
      LC_MONETARY = systemSettings.locale;
      LC_NAME = systemSettings.locale;
      LC_NUMERIC = systemSettings.locale;
      LC_PAPER = systemSettings.locale;
      LC_TELEPHONE = systemSettings.locale;
      LC_TIME = systemSettings.locale;
    };

    users.users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.name;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = [];
      uid = 1000;
    };

    environment.systemPackages = with pkgs; [
      neovim
      wget
      git
      home-manager
      zsh
    ];

    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh = {
      enable = true;
    };

    services.openssh.enable = true;

    networking.firewall.enable = false;
    networking.nat.enable = false;
    networking.usePredictableInterfaceNames = true;
    networking.useDHCP = lib.mkDefault true;
    
    security.sudo.wheelNeedsPassword = false;

    system.stateVersion = "23.11";
  };
}
{
  description = "Wuryzul's NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    home-manager-unstable.url = "github:nix-community/home-manager/master";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/release-23.11";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = inputs@{ self, nixos-wsl, nixpkgs, ... }: 
    let
        systemSettings = {
          system = "x86_64-linux";
          hostname = "alexandria";
          profile = "wsl";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
        };
        userSettings = {
          username = "wury";
          name = "Eric";
          email = "wuryzul@gmail.com";
          dotfilesDir = "~/.dotfiles";
          editor = "nvim";
        };
      home-manager = (if ((systemSettings.profile == "homelab") || (systemSettings.profile == "worklab"))
             then
               inputs.home-manager-stable
             else
               inputs.home-manager-unstable);
      pkgs = (if ((systemSettings.profile == "homelab") || (systemSettings.profile == "worklab"))
              then
                pkgs-stable
              else
                (import nixpkgs {
                  system = systemSettings.system;
                  config = {
                    allowUnfree = true;
                    allowUnfreePredicate = (_: true);
                  };
                }));

      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      lib = (if ((systemSettings.profile == "homelab") || (systemSettings.profile == "worklab"))
             then
               inputs.nixpkgs-stable.lib
             else
               inputs.nixpkgs.lib);
      wslModule = (if ((systemSettings.profile == "wsl"))
        then
          nixos-wsl.nixosModules.wsl
        else
          null);
    in {
      homeConfigurations = {
        "${userSettings.username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
      nixosConfigurations = {
        "${systemSettings.hostname}" = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            wslModule
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
          ];
          specialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };
}

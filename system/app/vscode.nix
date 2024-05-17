{ config, libs, pkgs, ... }: {
  imports = [
    (fetchTarball { 
      url = "https://github.com/nix-community/nixos-vscode-server/tarball/fc900c16efc6a5ed972fb6be87df018bcf3035bc"; 
      sha256 = "1rq8mrlmbzpcbv9ys0x88alw30ks70jlmvnfr2j8v830yy5wvw7h";
    })
  ];

  services.vscode-server.enable = true;
}

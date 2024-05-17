{ systemSettings, userSettings, pkgs, ... }: {
  imports = [

  ];

  config = {
    programs.home-manager.enable = true;

    home = {
      username = userSettings.username;
      sessionPath = [
        "~/bin"
      ];
      sessionVariables = {
        EDITOR = "nvim";
        SUDO_EDITOR = "nvim";
        VISUAL = "nvim";
        DIRENV_LOG_FORMAT = "";
      };
      file = {
        bin.source = ../../user/home/bin;
        ".gitconfig".source = ../../user/home/.gitconfig;
        nvim = {
          source = ../../user/home/.config/nvim;
          target = ".config/nvim";
          recursive = true;
        };
        ssh = {
          source = ../../user/home/.ssh;
          target = ".ssh";
          recursive = true;
        };
        tmux = {
          source = ../../user/home/.config/tmux;
          target = ".config/tmux";
          recursive = true;
        };
        zsh = {
          source = ../../user/home/.config/zsh;
          target = ".config/zsh";
          recursive = true;
        };
      };

      homeDirectory = "/home/" + userSettings.username;

      packages = with pkgs; [
        direnv
        nix-direnv
        fd
        grc
        just
        ranger
        ripgrep
        tmux
        eza
        zsh-completions
        zsh-syntax-highlighting
        zsh-history-substring-search
        zsh-powerlevel10k
      ];

      stateVersion = "23.11";
    };

    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
        ];
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "sudo" "terraform" "systemadmin" "vi-mode" "docker" ];
        };
        dotDir = "~/.config/zsh";
        shellAliases = {
          vi = "nvim";
          ll = "ls -l";
          ls = "exa";
          la = "exa -a";
          grep = "grep --color=auto";
          cp = "cp -i";
          mv = "mv -i";
          rm = "rm -i";
          g = "git";
          gs = "git status";
        };
        initExtra = ''
          source ~/.config/zsh/.p10k.zsh
          source ~/.config/zsh/zshrc
        '';
      };
    };
  };
}
{ pkgs, lib, config, ... }:

let cfg = config.zsh; in {
  options = {
    zsh.enable = lib.mkEnableOption "ZSh";

    zsh.option = lib.mkOption {
      default = "";
      type = lib.types.str;
      description = "zsh option";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.zsh pkgs.zinit ];
    environment.shells = [ pkgs.zsh ];
    environment.pathsToLink = [ "/share/zsh" ];

    users.defaultUserShell = pkgs.zsh;
    users.users."caret".useDefaultShell = true;

    programs.zsh.enable = true;

    home-manager.users."caret".programs.zsh = {
      enable = true;
      enableCompletion = false; # disable completion on home-level

      antidote = {
        enable = true;

        useFriendlyNames = true;

        plugins = [
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-completions"
          "zsh-users/zsh-autosuggestions"
          "aloxaf/fzf-tab"
          "jeffreytse/zsh-vi-mode"
        ];
      };

      initExtra = builtins.readFile ./config.zsh;

      shellAliases = {
        t = "tree --filesfirst";
        ls = "ls --color";
      };

      history = {
        size = 10000;
        save = 10000;
        share = false;
        
        ignoreAllDups = true;
        ignoreSpace = true;
      };
    };
  };
}

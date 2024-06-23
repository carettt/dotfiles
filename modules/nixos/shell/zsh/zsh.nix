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

  config = lib.mkIf cfg.enable (let
    plugins = [
      "zsh-users/zsh-syntax-highlighting"
      "zsh-users/zsh-completions"
      "zsh-users/zsh-autosuggestions"
      "aloxaf/fzf-tab"
      "jeffreytse/zsh-vi-mode"
    ];
  in {
    environment.systemPackages = [ pkgs.zsh pkgs.antidote ];
    environment.shells = [ pkgs.zsh ];
    environment.pathsToLink = [ "/share/zsh" "/share/antidote" ];

    users.defaultUserShell = pkgs.zsh;
    users.users."caret".useDefaultShell = true;

    programs.zsh = {
      enable = true; # i do what the compiler tells me to

      # disable completion and do it manually in config.zsh
      enableCompletion = false;
    };

    home-manager.users."caret".home.file.".zshrc".source = ./config.zsh;
    home-manager.users."caret".home.file.".zsh_plugins.txt" = {
      # credit for the nice reduction function:
      # https://discourse.nixos.org/t/nix-list-print-each-element-of-a-list-aka-string-to-file-aka-debugging/10863/2
      text = builtins.foldl' (x: y: x + y + "\n") "" plugins; 
    };
  });
}

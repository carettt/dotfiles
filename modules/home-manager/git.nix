{ inputs, pkgs, lib, config, ... }:

let cfg = config.git; in {
  options = {
    git.enable = lib.mkEnableOption "enables git";

    git.name = lib.mkOption {
      type = lib.types.string;
      description = "Name associated with all git actions";
    };
    git.email = lib.mkOption {
      type = lib.types.string;
      description = "Emal associated with all git actions";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gh ];    

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
    };
  };
}

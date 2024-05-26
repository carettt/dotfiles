{ inputs, pkgs, lib, config, ... }:

{
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

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = config.git.name;
      userEmail = config.git.email;
    };
  };
}

{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.direnv;
in {
  options = {
    direnv.enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };

    home.sessionVariables.DIRENV_LOG_FORMAT = "";
  };
}

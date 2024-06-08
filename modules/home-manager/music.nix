{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.music;
in {
  options = {
    music.enable = lib.mkEnableOption "music client and utilities";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ncspot pkgs.playerctl ];
  };
}

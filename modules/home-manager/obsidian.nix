{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.obsidian;
in {
  options = {
    obsidian.enable = lib.mkEnableOption "obsidian";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.obsidian ];
  };
}

{ inputs, pkgs, lib, config, ... }:

let cfg = config.terminal; in {
  options = {
    terminal.enable = lib.mkEnableOption "terminal packages";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty.enable = true;
  };
}

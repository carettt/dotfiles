{ inputs, pkgs, lib, config, ... }:

let cfg = config.browser; in {
  options = {
    browser.enable = lib.mkEnableOption "Firefox browser";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}

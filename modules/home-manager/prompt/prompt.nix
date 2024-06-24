{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.prompt;
in {
  options = {
    prompt.enable = lib.mkEnableOption "prompt";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.oh-my-posh ];

    xdg.configFile."ohmyposh/conf.yaml".source = ./conf.yaml;
  };
}

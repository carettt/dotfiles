{ pkgs, lib, config, ... }:

let cfg = config.networkingTools; in {
  options = {
    networkingTools.enable = lib.mkEnableOption "networkingTools";

    networkingTools.nmap = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Whether to enable nmap bundle (default true)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.lists.optionals cfg.nmap [ pkgs.nmap ];
  };
}

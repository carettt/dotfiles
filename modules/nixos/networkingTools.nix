{ pkgs, lib, config, ... }:

let cfg = config.networkingTools; in {
  options = {
    networkingTools.enable = lib.mkEnableOption "networkingTools";

    networkingTools.netcat = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Whether to enable netcat (default true)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      lib.mkIf cfg.netcat pkgs.netcat
    ];
  };
}

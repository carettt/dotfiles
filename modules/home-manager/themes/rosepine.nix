{ inputs, pkgs, lib, config, ... }:

let cfg = config.rosepine; in {
  options = {
    rosepine.enable = lib.mkEnableOption "rosepine theme";
  };

  config = lib.mkIf cfg.enable {
    # Module options here ...
  };
}

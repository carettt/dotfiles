{ pkgs, lib, config, ... }:

let cfg = config.module; in {
  options = {
    module.enable = lib.mkEnableOption "module";

    module.option = lib.mkOption {
      default = "";
      type = lib.types.str;
      description = "module option";
    };
  };

  config = lib.mkIf cfg.enable {
    # Module options here ...
  };
}

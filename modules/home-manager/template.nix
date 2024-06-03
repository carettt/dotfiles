{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.module;
  utils = import ../utils.nix { inherit lib; };
in {
  options = {
    module.enable = lib.mkEnableOption "module";

    module.override = lib.mkOption {
      default = {};
      type = lib.types.attrs;
      description = "Override module settings";
    };
  };

  config = lib.mkIf cfg.enable {
    # Module options here ...
  };
}

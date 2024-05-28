{ pkgs, lib, config, ... }:

{
  options = {
    module.enable = lib.mkEnableOption "enables module";

    module.option = lib.mkOption {
      default = ""
      type = lib.types.string;
      description = "module option";
    };
  };

  config = lib.mkIf config.module.enable {
    # Module options here ...
  };
}

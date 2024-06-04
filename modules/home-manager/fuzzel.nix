{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.fuzzel;
  utils = import ../utils.nix { inherit lib; };
in {
  options = {
    fuzzel.enable = lib.mkEnableOption "Fuzzel application launcher";
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.enable = true;
  };
}

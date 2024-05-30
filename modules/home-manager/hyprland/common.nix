{ inputs, pkgs, lib, config, ... }:

let cfg = config.hyprland; in {
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";

    hyprland.flavour = lib.mkOption {
      default = ./plain.nix;
      type = lib.types.path;
      description = "Which flavour of hyprland to enable";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
  };
}

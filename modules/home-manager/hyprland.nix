{ inputs, pkgs, lib, ... }:

{
  options = {
    hyprland.enable = lib.mkEnable "Enable hyprland wm";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {

    };
  };
}
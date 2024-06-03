{ inputs, pkgs, lib, config, ... }:

let cfg = config.desktop; in {
  options = {
    desktop.enable = lib.mkEnableOption "desktop environment";

    desktop.hyprland = lib.mkOption {
      description = "Whether to enable Hyprland WM";
      type = lib.types.bool;
      default = true;
    };

    desktop.swaybg = {
      enable = lib.mkEnableOption "SwayBG";
      wallpaper = lib.mkOption {
        description = "Path to wallpaper image";
        type = lib.types.path;
      };
    };

    desktop.waybar = lib.mkOption {
      description = "Whether to enable Waybar";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.lists.optionals cfg.swaybg.enable [ pkgs.swaybg ];
    
    waybar.enable = true;

    hyprland = {
      enable = cfg.hyprland;

      override = {
        exec-once =  
          lib.lists.optionals cfg.waybar [ "waybar" ] ++
          lib.lists.optionals cfg.swaybg.enable [ "swaybg -i ${cfg.swaybg.wallpaper}" ];
      };
    };
  };
}

{ inputs, pkgs, lib, config, ... }:

let cfg = config.desktop; in {
  options = {
    desktop = {
      enable = lib.mkEnableOption "desktop environment";

      hyprland = lib.mkOption {
        description = "Whether to enable Hyprland WM";
        type = lib.types.bool;
        default = true;
      };

      swaybg = {
        enable = lib.mkEnableOption "SwayBG";
        wallpaper = lib.mkOption {
          description = "Path to wallpaper image";
          type = lib.types.path;
        };
      };

      waybar = {
        enable = lib.mkEnableOption "Waybar";
        style = lib.mkOption {
          description = "Waybar CSS style";
          type = lib.types.str;
        };
      };

      fuzzel.enable = lib.mkEnableOption "Fuzzel application launcher";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.lists.optionals cfg.swaybg.enable [ pkgs.swaybg ];
    
    waybar.enable = true;
    programs.waybar.style = lib.mkForce cfg.waybar.style;

    hyprland = {
      enable = cfg.hyprland;

      override = {
        exec-once =  
          lib.lists.optionals cfg.waybar.enable [ "waybar" ] ++
          lib.lists.optionals cfg.swaybg.enable [ "swaybg -i ${cfg.swaybg.wallpaper}" ];
      };
    };

    fuzzel.enable = cfg.fuzzel.enable;
  };
}

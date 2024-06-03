{ inputs, pkgs, lib, config, ... }:

let cfg = config.rosepine; in {
  options = {
    rosepine.enable = lib.mkEnableOption "rosepine theme";

    rosepine.hyprland = lib.mkOption {
      description = "Whether to enable Hyprland WM";
      type = lib.types.bool;
      default = true;
    };

    rosepine.swaybg = lib.mkOption {
      description = "Whether to enable SwayBG daemon";
      type = lib.types.bool;
      default = true;
    };

    rosepine.waybar = lib.mkOption {
      description = "Whether to enable Waybar";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      lib.lists.optionals cfg.swaybg [ pkgs.swaybg ];

    waybar.enable = true;

    hyprland = {
      enable = cfg.hyprland;

      override = {
        exec-once = 
          lib.lists.optionals cfg.swaybg [ "swaybg -i ~/dotfiles/modules/home-manager/themes/wallpapers/rosepine-wp.png" ] ++
          lib.lists.optionals cfg.waybar [ "waybar" ];
      };
    };
  };
}

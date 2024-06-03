{ pkgs, inputs, lib, config, ... }:

let
  cfg = config.rosepine;
in {
  options = {
    rosepine.enable = lib.mkEnableOption "Rosé Pine Theme";

    rosepine.wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Path to wallpaper image";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."caret" = {
      desktop = {
        enable = true;
        swaybg = {
          enable = true;
          wallpaper = cfg.wallpaper;
        };
      };

      wayland.windowManager.hyprland.settings = {
        windowrulev2 = [
          "opacity 0.75 0.65,class:(Alacritty)"
        ];

        decoration = {
          rounding = lib.mkForce 0;
          blur = { 
            size = lib.mkForce 12;
            passes = lib.mkForce 2;
            special = true;
          };
        };
      };

      programs.alacritty.settings.window.blur = lib.mkForce true;
    };
     
    stylix = {
      image = cfg.wallpaper;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

      cursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; };
          name = "Hack Nerd Font Mono";
        };

        sansSerif = {
          package = pkgs.overpass;
          name = "Overpass";
        };

        serif = config.stylix.fonts.sansSerif;
      };
    };  
  };
}

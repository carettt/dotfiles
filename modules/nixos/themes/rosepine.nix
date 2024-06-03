{ pkgs, lib, config, ... }:

let cfg = config.rosepine; in {
  options = {
    rosepine.enable = lib.mkEnableOption "Rosé Pine Theme";

    rosepine.wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Path to wallpaper image";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."caret".desktop = {
      enable = true;
      swaybg = {
        enable = true;
        wallpaper = cfg.wallpaper;
      };
    };
    
    stylix = {
      image = cfg.wallpaper;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    };
  };
}

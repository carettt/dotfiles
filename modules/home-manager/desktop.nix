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

      notifications = {
        enable = lib.mkEnableOption "Sway notification center";
        style = lib.mkOption {
          description = "SwayNC style";
          type = lib.types.str;
        };
      };

      fuzzel.enable = lib.mkEnableOption "Fuzzel application launcher";
      powermenu.enable = lib.mkEnableOption "nwg-bar power menu";
      utilities.enable = lib.mkEnableOption "miscellaneous utilities";
      discord.enable = lib.mkEnableOption "Dissent Discord client";
      office.enable = lib.mkEnableOption "LibreOffice software";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.lists.optionals cfg.swaybg.enable [ pkgs.swaybg ] ++
                    lib.lists.optionals cfg.discord.enable [ pkgs.discord ] ++
                    lib.lists.optionals cfg.office.enable [ pkgs.libreoffice ] ++
                    lib.lists.optionals cfg.utilities.enable [
                      pkgs.lxqt.lxqt-policykit
                      pkgs.copyq pkgs.wl-clipboard
                      pkgs.grim pkgs.slurp
                    ];

    waybar.enable = cfg.waybar.enable;
    programs.waybar.style = lib.mkForce cfg.waybar.style;

    hyprland = {
      enable = cfg.hyprland;

      override = {
        exec-once =  
          lib.lists.optionals cfg.waybar.enable [ "waybar" ] ++
          lib.lists.optionals cfg.swaybg.enable [ "swaybg -o * -i ${cfg.swaybg.wallpaper}" ] ++
          lib.lists.optionals cfg.notifications.enable [ "swaync" ] ++
          lib.lists.optionals cfg.utilities.enable [ "lxqt-policykit-agent" "copyq --start-server" ];
      };
    };

    fuzzel.enable = cfg.fuzzel.enable;
    programs.fuzzel.settings.main.list-executables-in-path = true;

    powermenu.enable = cfg.powermenu.enable;

    services.swaync = {
      enable = cfg.notifications.enable;
      package = pkgs.swaynotificationcenter;
      style = cfg.notifications.style;
      settings = {
        fit-to-screen = true;
        widgets = [
          "inhibitors"
          "title"
          "dnd"
          "mpris"
          "volume"
          "notifications"
        ];
      };
    };

    xdg.portal = lib.mkIf cfg.utilities.enable {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "hyprland";
    };
  };
}

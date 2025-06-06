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

        fuzzel.enable = true;
        powermenu.enable = true;
        utilities.enable = true;

        notifications = {
          enable = true;
          style = ''
            .control-center {
              margin: 30px;
              background-color: rgba(57, 53, 82, 0.55);
              border-radius: 0;
              border: 2px solid #908CAA;
            }

            .notification {
              padding: 8px;
              margin: 20px 15px 0 0;
              background-color: rgba(57, 53, 82, 0.55);
              color: #E0DEF4;
              border-radius: 0;
              border: 2px solid #908CAA;
            }

            .close-button {
              margin: 35px 30px;
            }

            .notification-default-action:hover {
              background-color: rgba(57, 53, 82, 0.55);
              box-shadow: none;
              border-radius: 0;
            }
          '';
        };

        waybar = {
          enable = true;
          style = ''
            * {
              border: none;
              border-radius: 0;
              min-height: 24px;
              padding: 0;
              margin: 0;
            }

            window#waybar, window > box {
              background-color: transparent;
              padding: 20px 20px 0;
            }

            .modules-left, .modules-right, .modules-center {
              background-color: #${config.stylix.base16Scheme.base02};
              border: 2px solid #${config.stylix.base16Scheme.base03};
              padding: 3px 8px;
            }

            .modules-left {
              margin-right: 20px;
            }

            .modules-right {
              margin-left: 20px;
            }

            #workspaces button, #workspaces button.label {
              color: #${config.stylix.base16Scheme.base03};
              min-width: 30px;
              padding-right: 3px;
              margin-right: 5px;
            }

            #workspaces button:hover {
              background-color: #${config.stylix.base16Scheme.base00};
              color: #${config.stylix.base16Scheme.base05};
            }

            #workspaces button.active {
              border: 2px solid #${config.stylix.base16Scheme.base0A};
              color: #${config.stylix.base16Scheme.base0A};
              padding-right: 3px;
              padding-left: 0;
              min-width: 30px;
            }

            #window {
              color: #${config.stylix.base16Scheme.base0D};
              padding-top: 3px;
            }

            #clock {
              padding: 3px 8px 0;
            }

            #bluetooth.off {
              color: #${config.stylix.base16Scheme.base03};
            }

            #bluetooth.disabled {
              color: #${config.stylix.base16Scheme.base08};
            }

            #bluetooth.on {
              color: #${config.stylix.base16Scheme.base0C};
            }

            #bluetooth.connected {
              color: #${config.stylix.base16Scheme.base0B};
            }
            
            #mpris {
              color: #${config.stylix.base16Scheme.base09};
              margin-right: 6px;
            }

            #mpris.paused {
              color: #${config.stylix.base16Scheme.base03};
            }

            #custom-notifications {
              color: #${config.stylix.base16Scheme.base05};
              padding: 0 4px;
            }

            #battery {
              padding: 0 15px 0 0;
            }

            #battery.warning {
              color: #${config.stylix.base16Scheme.base09};
            }

            #battery.critical {
              color: #${config.stylix.base16Scheme.base09};
            }
          '';
        };
      };

      wayland.windowManager.hyprland.settings = {
        general."col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0D})";

        windowrule = [
          "opacity 0.75 0.65,class:^(Alacritty)$"
          "workspace 1,class:^(Alacritty)$"
          "workspace 2,class:^(firefox)$"
          "workspace 3,class:^(discord)$"
          "workspace 4,title:^(overskride)$"
          "float,title:^(Authentication Required)$"
          "float,title:^(overskride)$"
          "float,class:^(com.github.hluk.copyq)$"
        ];

        layerrule = [
          "blur,^(swaync-control-center)$"
          "blur,^(swaync-notification-window)$"
          "ignorezero,^(swaync-control-center)$"
          "ignorezero,^(swaync-notification-window)$"
          "ignorealpha 0.5,^(swaync-control-center)$"
          "ignorealpha 0.5,^(swaync-notification-window)$"
        ];

        decoration = {
          rounding = lib.mkForce 0;
          blur = { 
            size = lib.mkForce 8;
            passes = lib.mkForce 2;
            special = true;
          };
        };
      };

      programs.alacritty.settings.window.blur = lib.mkForce true;
    };
     
    stylix = {
      enable = true;

      image = cfg.wallpaper;

      base16Scheme = {
        base00 = "232136";
        base01 = "2a273f";
        base02 = "393552";
        base03 = "6e6a86";
        base04 = "908caa";
        base05 = "e0def4";
        base06 = "e0def4";
        base07 = "56526e";
        base08 = "eb6f92";
        base09 = "f6c177";
        base0A = "ea9a97";
        base0B = "3e8fb0";
        base0C = "9ccfd8";
        base0D = "c4a7e7";
        base0E = "f6c177";
        base0F = "56526e";
      };

      cursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
      };

      fonts = {
        emoji = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font";
        };

        monospace = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font";
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

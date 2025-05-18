{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.hyprland;
  utils = import ../utils.nix { inherit lib; };
in {
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";

    hyprland.override = lib.mkOption {
      default = {};
      type = lib.types.attrs;
      description = "Hyprland override settings";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;

      settings = utils.recursiveMerge [{
        # Monitors
        monitor = [
          "eDP-1,2560x1440@165,0x0,1.6"
          "HDMI-A-1,1920x1080@60,1600x0,1" # Take scaling into account (resolution / scaling = offset)
          ",preferred,auto,1.6"
        ];

        # Program Shortcuts
        "$terminal" = "alacritty";
        "$fileManager" = "";
        "$menu" = "fuzzel --no-icons --terminal='alacritty -e'";
        "$powermenu" = "nwg-bar";

        # Autostart
        exec-once = [
          
        ];

        # Environment Variables
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        # Tiling
        general = {
          gaps_in = 5;
          gaps_out = 20;

          border_size = 2;
          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # Aesthetic
        misc.force_default_wallpaper = 0;

        decoration = {
          rounding = 10;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          # Shadows
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = lib.mkDefault "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Input
        input = {
          kb_layout = "us";
          kb_variant = "";

          numlock_by_default = true;

          follow_mouse = 1;
          sensitivity = 0;

          touchpad.natural_scroll = true;
        };

        # Keybindings
        "$mod" = "ALT";

        bind = [
          # General
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive,"
          "$mod, M, exec, $powermenu"
          "$mod, E, exec, $fileManager"
          "$mod, SPACE, exec, $menu"
          "$mod, P, pseudo,"
          "$mod, G, togglesplit,"
          "$mod, V, togglefloating"
          "$mod, F, fullscreen"
          "$mod, R, exec, hyprctl reload"
          "$mod, W, exec, copyq toggle"

          # Screenshots
          "$mod, Z, exec, grim -g \"$(slurp)\" - | wl-copy"
          "$mod SHIFT, Z, exec, grim -o \"$(slurp -o -f '%o')\" - | wl-copy"

          # Focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"

          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, s, movetoworkspace, special:magic"
        ];

        # Mouse Bindings
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # Rules
        windowrule = [
          "suppressevent maximize, class:.*"
          "float, class:(caret).(.*)"
        ];

        workspace = [
          "1,monitor:HDMI-A-1,default:true"
          "2,monitor:eDP-1,default:true"
          "3,monitor:eDP-1"
          "4,monitor:eDP-1"
          "special:magic,monitor:HDMI-A-1"
        ];
      } cfg.override];
    };
  };
}

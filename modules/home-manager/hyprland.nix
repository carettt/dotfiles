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
        monitor= [
          ",preferred,auto,auto"
          "Unknown-1,disable" # Disable ghost monitor (fuck NVIDIA)
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

        master = {
          new_is_master = true;
        };

        # Aesthetic
        misc.force_default_wallpaper = 0;

        decoration = {
          rounding = 10;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          # Shadows
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = lib.mkDefault "rgba(1a1a1aee)";

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
          "$mod, D, exec, $menu"
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
        windowrulev2 = [
          "suppressevent maximize, class:.*"
        ];
      } cfg.override];
    };
  };
}

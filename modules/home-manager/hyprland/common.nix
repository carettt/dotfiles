{ inputs, pkgs, lib, config, ... }:

let cfg = config.hyprland; in {
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";

    hyprland.flavour = lib.mkOption {
      default = ./plain.nix;
      type = lib.types.path;
      description = "Which flavour of hyprland to enable";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;

      settings = {
        # Monitors
        monitor= [
          ",preferred,auto,auto"
          "Unknown-1,disable" # Disable ghost monitor (fuck NVIDIA)
        ];

        # Program Shortcuts
        "$terminal" = "alacritty";
        "$menu" = "";

        # Autostart
        exec-once = [
          
        ];

        # Environment Variables
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        # Aesthetic

        ## Tiling
        general = {
          gaps_in = 5;
          gaps_out = 20;

          border_size = 2;
          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };
      };
    };
  };
}

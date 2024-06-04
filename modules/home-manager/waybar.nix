{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.waybar;
  utils = import ../utils.nix { inherit lib; };
in {
  options = {
    waybar.enable = lib.mkEnableOption "waybar";

    waybar.override = lib.mkOption {
      default = {};
      type = lib.types.attrs;
      description = "Override waybar settings";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = utils.recursiveMerge [{
        mainBar = {
          layer = "top";

          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "clock" ];
          modules-right = [ "bluetooth" "cpu" "custom/gpu" "memory" "network" ];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "󰈹";
              "3" = "󰭹";
              "4" = "󰓇";
            };
            
            persistent-workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
            };
          };

          network = {
            format = "󱦲{bandwidthUpBytes} / 󱦳{bandwidthDownBytes}";
          };

          "custom/gpu" = {
            exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader";
            format = "GPU: {}";
            return-type = "";
            interval = 1;
          };

          cpu = {
            format = "CPU: {usage} %";
          };

          bluetooth = {
            format = "󰂯";
          };

          memory = {
            format = "RAM: {percentage} %";
          };
        };
      } cfg.override];
    };
  };
}

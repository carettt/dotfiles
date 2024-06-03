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

          modules-left = [ "hyprland/window" "privacy" ];
          modules-center = [ "clock" ];
          modules-right = [ "cpu" "custom/gpu" "memory" "network" ];

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


          memory = {
            format = "RAM: {percentage} %";
          };
        };
      } cfg.override];
    };
  };
}

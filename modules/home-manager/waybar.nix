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
          modules-right = lib.lists.optionals config.music.enable [ "mpris" ] ++ [ "bluetooth" ];

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

          bluetooth = {
            format = "󰂯";
          };

          mpris = {
            format = "{player_icon} {dynamic}";
            format-paused = "{status_icon} <i>{dynamic}</i>";

            dynamic-order = [ "title" "artist" ];

            player-icons = {
              default = "󰐊";
              ncspot = "󰎇";
            };
            status-icons = {
              paused = "󰏤";
            };
          };
        };
      } cfg.override];
    };
  };
}

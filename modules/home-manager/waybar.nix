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
          modules-right = lib.lists.optionals config.music.enable [ "mpris" ] ++ [ "bluetooth" "custom/notifications" ];

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

          "custom/notifications" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "󱅫";
              none = "󰂚";
              dnd-notification = "󰂛";
              dnd-none = "󰂛";
              inhibited-notification = "󱅫";
              inhibited-none = "󰂚";
              dnd-inhibited-notification = "󰂛";
              dnd-inhibited-none = "󰂛";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };
        };
      } cfg.override];
    };
  };
}

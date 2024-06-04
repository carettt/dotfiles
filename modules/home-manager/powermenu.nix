{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.powermenu;
in {
  options = {
    powermenu.enable = lib.mkEnableOption "powermenu";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nwg-bar ];

    xdg.configFile = {
      "nwg-bar/bar.json".text = ''
        [
          {
            "label": "Logout",
            "exec": "hyprctl dispatch exit",
            "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-log-out.svg"
          },
          {
            "label": "Reboot",
            "exec": "systemctl reboot",
            "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-reboot.svg"
          },
          {
            "label": "Shutdown",
            "exec": "systemctl -i poweroff",
            "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-shutdown.svg"
          }
        ]
      '';
    };

    xdg.configFile = {
      "nwg-bar/style.css".text = ''
        #inner-box {
          background-color: #${config.stylix.base16Scheme.base03};
          color: #${config.stylix.base16Scheme.base05};
          border-radius: 0;
          padding: 10px;
        }

        button {
          background-color: #${config.stylix.base16Scheme.base02};
          border-radius: 0;
          margin: 2px;
        }

        button:hover {
          background-color: #${config.stylix.base16Scheme.base00};
          color: #${config.stylix.base16Scheme.base09};
        }
      '';
    };
  };
}

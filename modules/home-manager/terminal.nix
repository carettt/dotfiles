{ inputs, pkgs, lib, config, ... }:

let cfg = config.terminal; in {
  options = {
    terminal.enable = lib.mkEnableOption "terminal packages";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.nerdfonts.override { fonts = ["Hack" ]; })
    ];

    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          padding = { x = 5; y = 5; };
          decorations = "None";
        };

        font = {
          size = 12.0;
          normal.family = "Hack Nerd Font";
          bold.family = "Hack Nerd Font";
          italic.family = "Hack Nerd Font";
        };

        cursor.style = { shape = "Beam"; blinking = "On"; };
      };
    };
  };
}
{ inputs, pkgs, lib, config, ... }:

let cfg = config.terminal; in {
  options = {
    terminal.enable = lib.mkEnableOption "terminal packages";

    terminal.alacrittyTheme = lib.mkOption {
      type = lib.types.path;
      description = "Path to alacritty theme named theme-[NAME].nix (overwrites default)";
    };
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
          normal.family = "Hack";
          bold.family = "Hack";
          italic.family = "Hack";
        };

        cursor.style = { shape = "Beam"; blinking = "On"; };
      };
    };
  };
}

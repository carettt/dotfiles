{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.terminal;
  utils = import ../utils.nix { inherit lib; };
in {
  imports = [
    ./neovim
  ];

  options = {
    terminal.enable = lib.mkEnableOption "terminal packages";

    terminal.alacrittySettings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Override default alacritty settings";
    };

    terminal.neovim.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable neovim editor";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.nerdfonts.override { fonts = ["Hack" ]; })
    ];

    programs.alacritty = {
      enable = true;

      settings = utils.recursiveMerge [{
        window = {
          padding = { x = 10; y = 10; };
          decorations = "None";
        };

        cursor.style = { shape = "Beam"; blinking = "On"; };
      } cfg.alacrittySettings];
    };

    neovim.enable = cfg.neovim.enable;
  };
}

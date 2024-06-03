{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.terminal;
  utils = import ../utils.nix { inherit lib; };
in {
  options = {
    terminal.enable = lib.mkEnableOption "terminal packages";

    terminal.alacrittySettings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Override default alacritty settings";
    };

    terminal.vim = lib.mkEnableOption "VIm editor";
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

    programs.vim = {
      enable = cfg.vim;

      extraConfig = ''
        set expandtab
        set smarttab
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
      '';
    };
  };
}

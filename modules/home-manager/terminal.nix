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
          padding = { x = 5; y = 5; };
          decorations = "None";
        };

        font = {
          size = lib.mkForce 12.0;
          normal.family = lib.mkForce "Hack Nerd Font";
          bold.family = lib.mkForce "Hack Nerd Font";
          italic.family = lib.mkForce "Hack Nerd Font";
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

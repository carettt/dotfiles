{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.neovim;
in {
  options = {
    neovim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gcc
      
      # LSPs
      pkgs.nixd
      pkgs.lua-language-server
      pkgs.rust-analyzer
      pkgs.bash-language-server
    ];

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      defaultEditor = true;

      vimAlias = true;
      vimdiffAlias = true;
    };

    xdg.configFile."nvim" = {
      recursive = true;
      source = ./config;
    };
  };
}

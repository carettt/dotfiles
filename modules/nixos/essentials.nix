{ lib, builtins, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    eza
    nh
    wget
    ripgrep
    fzf
    just
    porsmo
    #thefuck
  ];

  security.polkit.enable = true;

  qt.enable = true;

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };

  #home-manager.users."caret" = {
  #  xdg.configFile = {
  #    "thefuck/settings.py".text = ''
  #      exclude_rules = [ "fix_file" ]
  #    '';
  #  };
  #  
  #  programs.thefuck = {
  #    enable = true;
  #    enableNushellIntegration = true;
  #    package = pkgs.thefuck;
  #  };
  #};
}

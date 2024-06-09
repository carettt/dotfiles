{ lib, builtins, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    tree
    nh
    wget
    ripgrep
    #thefuck
  ];

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

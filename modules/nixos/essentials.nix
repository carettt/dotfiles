{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    tree
    nh
    wget
    ripgrep
  ];
}

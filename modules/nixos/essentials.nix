{ lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    tree
    nh
    wget
  ];
}

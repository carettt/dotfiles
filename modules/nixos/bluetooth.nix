{ pkgs, lib, config, ... }:

let cfg = config.bluetooth; in {
  options = {
    bluetooth.enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf cfg.enable {
    audio.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    environment.systemPackages = [ pkgs.overskride ];
  };
}

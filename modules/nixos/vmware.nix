{ pkgs, lib, config, ... }:

let cfg = config.vmware; in {
  options = {
    vmware.enable = lib.mkEnableOption "VMWare Workstation Pro";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.vmware.host.enable = true;
    virtualisation.vmware.host.package = pkgs.vmware-workstation;
  };
}

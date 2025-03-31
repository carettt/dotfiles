{ pkgs, lib, config, ... }:

let cfg = config.virt; in {
  options = {
    virt = {
      enable = lib.mkEnableOption "Virtualisation software";
      vmware.enable = lib.mkEnableOption "VMWare Workstation Pro";
      docker.enable = lib.mkEnableOption "Docker containerization";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf cfg.vmware.enable {
      virtualisation.vmware.host = {
        enable = true;
        package = pkgs.vmware-workstation;
      };

      networking.firewall.trustedInterfaces = [
        "vmnet1"
        "vmnet8"
      ];
    })
    (lib.mkIf cfg.docker.enable {
      virtualisation.docker = {
        enable = cfg.docker.enable;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };

      users.extraGroups.docker.members = [ "caret" ];
    })
  ]);
}

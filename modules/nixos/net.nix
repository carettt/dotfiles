{ pkgs, lib, config, ... }:

let cfg = config.net; in {
  options = {
    net = {
      enable = lib.mkEnableOption "Networking suite";

      nmap.enable = lib.mkOption {
        default = true;
        type = lib.types.bool;
        description = "Whether to enable NMAP network scanner";
      };

      wireshark.enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Whether to enable WireShark packet sniffer";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      environment.systemPackages =
        lib.lists.optionals cfg.nmap.enable [ pkgs.nmap ] ++
        lib.lists.optionals cfg.wireshark.enable [ pkgs.wireshark ];
    })
    
    (lib.mkIf (cfg.enable && cfg.wireshark.enable) {
      users.groups.wireshark = {};
      
      security.wrappers.dumpcap = {
        source = "${pkgs.wireshark}/bin/dumpcap";
        capabilities = "cap_net_raw,cap_net_admin+eip";
        owner = "root";
        group = "wireshark";
        permissions = "u+rx,g+x";
      };
    })
  ];
}

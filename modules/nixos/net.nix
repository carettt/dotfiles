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

      wireshark.enable = lib.mkEnableOption "WireShark packet sniffer";

      openvpn.enable = lib.mkEnableOption "OpenVPN protocol";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      environment.systemPackages =
        lib.lists.optionals cfg.nmap.enable [ pkgs.nmap ] ++
        lib.lists.optionals cfg.wireshark.enable [ pkgs.wireshark ] ++
        lib.lists.optionals cfg.openvpn.enable [ pkgs.openvpn ];
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

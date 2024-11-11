{ pkgs, lib, config, ... }:

let cfg = config.graphics; in {
  options = {
    graphics = {
      enable = lib.mkEnableOption "graphics & tweaks";
      nvidia.enable = lib.mkEnableOption "NVIDIA drivers";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.nvidia.enable {
     services.xserver.videoDrivers = [ "nvidia" ];
     hardware.nvidia = {
       modesetting.enable = true;
       open = false;
       nvidiaSettings = true;
       package = config.boot.kernelPackages.nvidiaPackages.stable;

       powerManagement = {
         enable = true;
       };
     };
    })

    (lib.mkIf cfg.enable {
       hardware.graphics.enable = true;

       console = {
         earlySetup = true;
         font = "${pkgs.terminus_font}/share/consolefonts/ter-i16n.psf.gz";
         packages = [ pkgs.terminus_font ];
         keyMap = "us";
       };
    })
  ];
}

{ pkgs, lib, config, ... }:

let cfg = config.nvidia; in {
  options = {
    nvidia.enable = lib.mkEnableOption "NVIDIA drivers";

    nvidia.opengl = lib.mkOption {
      description = "Whether to enable OpenGL";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
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

    hardware.opengl.enable = cfg.opengl;

    console = {
      earlySetup = true;
      font = "${pkgs.terminus_font}/share/consolefonts/ter-i16n.psf.gz";
      packages = [ pkgs.terminus_font ];
      keyMap = "us";
    };
  };
}

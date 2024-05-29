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
    };

    hardware.opengl = lib.mkIf cfg.opengl {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}

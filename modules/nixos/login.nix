{ pkgs, lib, config, ... }:

let cfg = config.login; in {
  options = {
    login.enable = lib.mkEnableOption "greetd & tuigreet Display Manager";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "console=tty1" ];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };
}

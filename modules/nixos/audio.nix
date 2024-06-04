{ pkgs, lib, config, ... }:

let cfg = config.audio; in {
  options = {
    audio.enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;

      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };

    environment.systemPackages = [ pkgs.pavucontrol ];
  };
}

{ inputs, pkgs, lib, config, ... }:

let cfg = config.browser; in {
  options = {
    browser.enable = lib.mkEnableOption "Firefox browser";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.carett = {
        search.engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icos/hicolor/scalable/apps/nix-snowflake.svg";

            definedAliases = [ "@np" ];
          };
        };

        search.force = true;
      };
    };
  };
}

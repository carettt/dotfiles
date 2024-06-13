{ pkgs, lib, config, ... }:

let cfg = config.shell; in {
  options = {
    shell.enable = lib.mkEnableOption "nushell";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nushell ];
    environment.shells = [ pkgs.nushell ];

    users.defaultUserShell = pkgs.nushell;
    users.users."caret".useDefaultShell = true;

    home-manager.users."caret".programs = let
      direnv = config.home-manager.users."caret".direnv.enable;
    in {
      nushell = {
        enable = true;
        configFile.source = ./config.nu;
        extraConfig = ''
          let carapace_completer = {|spans|
            carapace $spans.0 nushell $spans | from json
          }

          $env.config = {
            show_banner: false,
            completions: {
              case_sensitive: false # case-sensitive completions
              quick: true    # set to false to prevent auto-selecting completions
              partial: true    # set to false to prevent partial filling of the prompt
              algorithm: "fuzzy"    # prefix or fuzzy

              external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                enable: true
                # set to lower can improve completion performance at the cost of omitting some options
                max_results: 100
                completer: $carapace_completer # check 'carapace_completer'
              }
            }
          }

          $env.PATH = ($env.PATH |
            split row (char esep) |
            prepend /home/myuser/.apps |
            append /usr/bin/env)
        '' + lib.strings.optionalString direnv ''
          $env.config.hooks.env_change.PWD = ({ ||
              if (which direnv | is-empty) {
                  return
              }

              direnv export json | from json | default {} | load-env
          })
        '';

        shellAliases = {
          t = "tree --filesfirst";
          fuck = "thefuck $'(history | last 1 | get command | get 0)'";
        };
      };

      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };

      starship = {
        enable = true;
        # TODO
      };
    };
  };
}

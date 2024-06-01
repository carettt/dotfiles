{ lib, ... }:

{
  imports = lib.fileset.toList (lib.fileset.fileFilter (file: file.name != "default.nix" && file.name != "template.nix" && ! lib.strings.hasPrefix "theme-" file.name && file.hasExt "nix") ./.);
}

{ lib, ... }:

{
  imports = lib.fileset.toList (lib.fileset.fileFilter (file: file.name != "default.nix" && file.name != "template.nix" && file.name != "flake.nix" && file.hasExt "nix") ./.);
}

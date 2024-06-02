{ lib }:

let
  # Credit to: srghma (https://stackoverflow.com/questions/54504685/nix-function-to-merge-attributes-records-recursively-and-concatenate-arrays)
  # Merges list of records, concatenates arrays, if two values can't be merged - the latter is preferred
  recursiveMerge = attrList:
    let f = attrPath:
      lib.zipAttrsWith (n: values:
        if lib.tail values == []
          then lib.head values
        else if lib.all lib.isList values
          then lib.unique (lib.concatLists values)
        else if lib.all lib.isAttrs values
          then f (attrPath ++ [n]) values
        else lib.last values
      );
    in f [] attrList;
in {
  inherit recursiveMerge;
}

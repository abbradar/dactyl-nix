{ src }:

let
  pkgs = import <nixpkgs> { };
in {
  pentadactyl = (pkgs.callPackage ./pentadactyl.nix { }).overrideDerivation (args: {
    inherit src;
  });
}

{ src
, supportedPlatforms ? [ "x86_64-linux" ]
}:

with (import <nixpkgs> { }).lib;
genAttrs supportedPlatforms (system:
  let
    pkgs = import <nixpkgs> {
      inherit system;
    };
  in {
    pentadactyl = pkgs.callPackage ./pentadactyl.nix { };
  }
)

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
    pentadactyl = overridePackage (pkgs.callPackage ./pentadactyl.nix { }) (args: {
      inherit src;
    });
  }
)

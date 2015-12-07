{ pkgs ? (import <nixpkgs> {})
}:

pkgs.callPackage ./pentadactyl.nix { }

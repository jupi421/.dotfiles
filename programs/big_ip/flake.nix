{
  description = "A flake for BIG-IP VPN client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };  # If your dependencies require unfree packages
        };
        lib = pkgs.lib;  # Add this line to define 'lib'
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.stdenv
            pkgs.glibc
            # Add other dependencies identified by `ldd`
          ];

          shellHook = ''
            # Set up environment variables if needed
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib.makeLibraryPath [ pkgs.glibc ]}
          '';
        };
      }
    );
}

{
  description = "NixOS flake with a conda dev environment for numpy and matplotlib";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        # This defines the default dev shell available via `nix develop`
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.conda ];

          # The shellHook checks for the conda environment, creates it if missing,
          # and then activates it.
          shellHook = ''
            # Only run if conda isn't already activated.
            if [ -z "$CONDA_DEFAULT_ENV" ]; then
              # Create the conda environment if the directory doesn’t exist.
              if [ ! -d "./.conda_env" ]; then
                echo "Creating conda environment..."
                conda-shell create --prefix ./.conda_env environment.yml
              fi
              echo "Activating conda environment..."
              conda-shell activate --prefix ./.conda_env
            fi
          '';
        };
      });
}

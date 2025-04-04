{
	description = "Example flake that provides a shell with conda pre-initialized for zsh";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
	};

	outputs = { self, nixpkgs, ... }:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
			};

			pythonEnv = pkgs.python3.withPackages (ps: with ps; [
				conda
			]);

		in {
			devShells.${system}.default = pkgs.mkShell {
				buildInputs = [
					pkgs.conda
					pkgs.cmake
					pkgs.mpi
					pkgs.llvmPackages_20.openmp
				];
			};
		};
}

{
	description = "Collagen Project";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
		colbuilder.url = "../../programs/extern/colbuilder/flake.nix";
	};

	outputs = { self, nixpkgs, flake-utils, colbuilder, ... }@inputs:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};

				pythonEnv = pkgs.python3.withPackages (ps: with ps; [
					numpy
					matplotlib
				]);
			in
				{
					devShell = pkgs.mkShell {
						buildInputs = [ 
							pythonEnv 
							colbuilder
						];
					};
				}
		);
}

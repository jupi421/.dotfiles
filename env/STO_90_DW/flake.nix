{
	description = "STO_90_DW";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
#		vasputil-flake.url = "path:/home/jay/.dotfiles/programs/extern/vasputil";
	};

	outputs = { self, nixpkgs, flake-utils}: #, vasputil-flake }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};

#				vasputil = vasputil-flake.packages.${system}.vasputil;

				pythonEnv = pkgs.python3.withPackages (ps: with ps; [
					numpy
					matplotlib
					scipy
					ase
					pybind11
				]);
			in
				{
					devShell = pkgs.mkShell {
						buildInputs = [
							pythonEnv 
#							vasputil 
						];
					};
				}
		);
}

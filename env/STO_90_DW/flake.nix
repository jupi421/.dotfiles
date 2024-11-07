{
	description = "STO_90_DW";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
		pybind11-stubgen-flake.url = "path:/home/jay/.dotfiles/programs/extern/pybind11-stubgen/";
#		vasputil-flake.url = "path:/home/jay/.dotfiles/programs/extern/vasputil";
	};

	outputs = { self, nixpkgs, flake-utils, pybind11-stubgen-flake, ... }@inputs: #, vasputil-flake }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};

#				vasputil = vasputil-flake.packages.${system}.vasputil;
				pybind11-stubgen = pybind11-stubgen-flake.packages.${system}.pybind11-stubgen;
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
						nativeBuildInputs = with pkgs; [
							pkg-config 
							cmake
						];

						buildInputs = [
							pythonEnv 
							pybind11-stubgen
#							vasputil 
						];

						# add compile_flags.txt for clangd linting
						shellHook = ''
							echo "$(python -m pybind11 --includes | awk '{ for (i = 1; i <= NF; i++ ) print $i }')" > compile_flags.txt
						'';
					};
				}
		);
}

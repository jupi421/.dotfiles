{
	description = "Collagen Project";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
		colbuilder-flake.url = "path:/home/jay/.dotfiles/programs/extern/colbuilder";
	};

	outputs = { self, nixpkgs, flake-utils, colbuilder-flake, ... }@inputs:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};

				colbuilder = colbuilder-flake.packages.${system}.colbuilder;

				pythonEnv = pkgs.python3.withPackages (ps: with ps; [
					numpy
					matplotlib
				]);
			in
				{
					devShells.default = pkgs.mkShell {

						buildInputs = [ 
							pythonEnv 
							colbuilder
							pkgs.pymol
							pkgs.muscle
						];

						shellHook = ''
							export PYTHONPATH=$(echo ${pkgs.lib.makeSearchPath "lib/python3.11/site-packages" [ colbuilder pythonEnv ]})
						'';
					};
				}
		);
}

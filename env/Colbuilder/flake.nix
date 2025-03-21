{
	description = "conda env";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils, ... }@inputs:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
					config = { allowUnfree = true; };
				};

				pythonEnv = pkgs.python3.withPackages (ps: with ps; [
					conda
				]);
			in
				{
					devShells.default = pkgs.mkShell {

						buildInputs = [ 
						#pythonEnv 
							pkgs.conda
							pkgs.steam-run	
						];

							#eval "$(conda shell.zsh hook)"
						shellInit = ''
							echo "Launching conda-shell with python=3.12, numpy, and matplotlib..."
							# The "exec" replaces the current shell so that direnv and interactive usage work seamlessly.
							exec conda-shell python=3.12 numpy matplotlib
						'';
					};
				}
		);
}

{
	description = "Collagen Project";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils, ... }@inputs:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};

				pythonEnv = pkgs.python3.withPackages (ps: with ps; [
					conda
				]);
			in
				{
					devShells.default = pkgs.mkShell {

						buildInputs = [ 
							pythonEnv 
							steam-run	
						];

						shellInit = ''
							eval "$(conda shell.zsh hook)"
						'';
					};
				}
		);
}

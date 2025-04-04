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
					config.allowUnfree = true;
				};
			in
				{
					devShells.default = pkgs.mkShell {

						buildInputs = [ 
							pkgs.conda
							pkgs.steam-run
						];
					};
				}
		);
}

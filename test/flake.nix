{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		cython3-0-9.url = "github:nixos/nixpkgs/92d295f588631b0db2da509f381b4fb1e74173c5";
	};

	outputs = { self, nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in
		{
			devShells.x86_64-linux.default = 
				pkgs.mkShell
					{
						nativeBuildInputs = with pkgs; [
							inputs.cython3-0-9.legacyPackages.${system}.python311Packages.cython
						];
					};
		};
}

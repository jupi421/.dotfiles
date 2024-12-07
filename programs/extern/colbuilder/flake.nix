{
	description = "Colbuilder flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
			};
		in{
			packages.${system}.colbuilder = pkgs.stdenv.mkDerivation {
				pname = "colbuilder";
				version = "2.0.0";
				src = pkgs.fetchFromGitHub {
					owner = "graeter-group";
					repo = "colbuilder";
					rev = "2.0.0";
					sha256 = "0000000000000000000000000000000000000000000000000000000000000000";
				};

				BuildInputs = [
					pkgs.pymol				
					pkgs.muscle
				];
			};
		};
}

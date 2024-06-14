{
	description = "A simple flake wrapping a Debian package";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs }:
		let
			system ="x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
			};
	in {
		packages.x86_64-linux = {
			pkgs.${system}.f5fpc = pkgs.stdenv.mkDerivation {
				name = "f5fpc";
				buildCommand = ''
					mkdir -p $out/bin
					tar -xvf ./BIGIPLinuxClient.tgz
					dpkg -x ./BIGIPLinuxClient/linux_f5cli.x86_64.deb f5cli_unpacked
					cp -r f5cli_unpacked/* $out/
			    '';
			};
	    };
    };
}

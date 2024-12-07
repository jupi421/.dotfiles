{
	description = "FHS environment for UCSF Chimera";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
			};
		in {
			chimera = pkgs.buildFHSUserEnv {
				name = "chimera-env";
				targetPkgs = pkgs: with pkgs; [
					  glibc
					  glib
					  fontconfig
					  libGL
					  libGLU
					  libXext
					  libXrender
					  libXft
					  libxcb
					  libXi
					  libXfixes
					  libSM
					  libICE
					  gtk2
					  gtk3
					  nss
					  nspr
					  zlib
					  libstdcxx5
					  gcc
					  libjpeg
					  bashInteractive
					  coreutils
				];

				profile = ''
					export HOME=${builtins.toString ./.}
				'';

				run-script = ''
					if [ -d "./chimera" ]; then
						./chimera/bin/chimera
					else
						chmod +x chimera*.bin
						./chimera*.bin
					fi
				'';
			};
		};
}

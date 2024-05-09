{
	description = "BigIP Client";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }: 
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};
			in {
				packages.bigip-client = pkgs.stdenv.mkDerivation {
					pname = "big-ip";
					version = "1.0";
					src = ./BIGIPLinuxClient.tgz;

					nativeBuildInputs = [ pkgs.tar, pkgs.gnugrep, pkgs.coreutils ];
					
					unpackPhase = "tar -xvf $src";

					#installPhase = ''
					#	cd BIGIPLinuxClient
					#	mkdir -p $out/bin
					#	cp -r * $out/bin
					#	cd $out/bin
					#	./old-version/Install.sh
					#'';

					installPhase = ''
						cd BIGIPLinuxClient
						mkdir -p $out/BIGIPLinuxClient
						cp -r * $out/BIGIPLinuxClient

						cd old-version/webinstaller
						chmod 0755 ./linux_sslvpn.pkg

						mkdir -p $out/bin
						mkdir -p $out/lib/F5Networks




						#./linux_sslvpn.pkg
						tail -n +102 linux_sslvpn.pkg | tar xzf -
						sed -n "5,24p" linux_sslvpn.pkg > f5networks.conf

						[ -d ~/.F5Networks ] || mkdir ~/.F5Networks
						[ -f ~/.F5Networks/f5networks.conf ] || { cat f5networks > ~/.F5Networks/f5networks.conf}

						REAL_USER=$(stat -f%Su $HOME)
						chown -R $REAL_USER	~/.F5Networks
						chmod 755 ~/.F5Networks
						chmod 0600 ~/.F5Networks/f5networks.conf

						sed -n "7,20p" linux_sslvpn.pkg > Install.sh




						rm -rf ./Install.sh
						rm -rf ./utils
						tar xpzf linux_sslvpn.tgz
						rm -rf ./linux_sslvpn.tgz

					'';
					
					meta = {
						description = "BIG-IP UniVie VPN client";
					};
				};

				defaultPackages.${system} = self.packages.${system}.bigip-client;
			}
		);
}

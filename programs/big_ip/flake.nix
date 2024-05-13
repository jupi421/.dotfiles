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
					src = self;

					nativeBuildInputs = [ pkgs.which ];
					
					unpackPhase = ''
						# unpack tgz file
						tar -xvf $src/BIGIPLinuxClient.tgz;
						cd BIGIPLinuxClient
						cd old-version/webinstaller
						chmod 0755 ./linux_sslvpn.pkg

						#./linux_sslvpn.pkg
						tail -n +102 linux_sslvpn.pkg | tar xzf - # creates utils folder
						sed -n "31,60p" linux_sslvpn.pkg > f5networks.conf

						#[ -d ~/.F5Networks ] || mkdir ~/.F5Networks
						#[ -f ~/.F5Networks/f5networks.conf ] || { cat f5networks > ~/.F5Networks/f5networks.conf}

					'';

					installPhase = ''
						# start Install.sh generated from linux_sslvpn.pkg
						mkdir -p $out/bin
						mkdir -p $out/lib/F5Networks
						
						tar xpzf linux_sslvpn.tgz # creates usr folder

						cat usr/local/lib/F5Networks/f5fpc_x86_64 > $out/bin/f5fpc # copy binary to $out/bin
						chmod +x $out/bin/f5fpc

						# continue with original Install.sh
						## copy binary to $out/bin even if the last two are not necessary
						cp -Rf usr/local/lib/F5Networks/SSLVPN $out/lib/F5Networks 
						cp usr/local/lib/F5Networks/f5fpc_* $out/lib/F5Networks
						cp usr/local/lib/F5Networks/uninstall_F5.sh $out/lib/F5Networks

						# clean up

					'';
					
					meta = {
						description = "BIG-IP UniVie VPN client";
					};
				};

				defaultPackages.${system} = self.packages.${system}.bigip-client;
			}
		);
}

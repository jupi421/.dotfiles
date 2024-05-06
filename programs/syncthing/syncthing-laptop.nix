{ pkgs, ... }: 

{
	services.syncthing = {
		enable = true;
		user = "jay";
		dataDir = "/home/jay/Documents/";
		configDir =	"/home/jay/Documents/.config/syncthing";
		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = {
				"pc" = { id = "RLN737H-BCBLOGZ-DTHW4Y3-QWFOYBZ-THVPAAC-2OCGZQ2-6TPY5IP-SUKAEAK"; };
			};
			folders = {
				"Documents" = {
					path = "/home/jay/Documents";
					devices = [ "laptop" ];
				};
			};
		};
	};
	
	networking.firewall.allowedTCPPorts = [ 8384 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}

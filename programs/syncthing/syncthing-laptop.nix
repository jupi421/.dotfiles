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
				"pc" = { id = "6EN6E67-AGBMW6R-LY22E3N-ET3GZD7-TQMLMUA-E2EG6L5-5YJW7G4-V5MN5Q5"; };
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

{ pkgs, ... }: 

{
	services.syncthing = {
		enable = true;
		user = "jay";
		dataDir = "/home/jay/Documents/";
		configDir =	"/home/jay/.config/syncthing";
		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = {
				"laptop" = { id = "OQI6ZK4-HN5NVQF-BHCLEB3-ZZ6GLV6-HH3CL4B-CJF76LJ-GDHUP6Y-KSJQHQ2"; };
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

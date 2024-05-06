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
					versioning = {
						type = "staggered";
						fsPath = "/home/jay/.Documents_backup/";
						params = {
							cleanInterval = "3600";
							maxAge = "15552000";
						};
					};
				};
			};
		};
	};
	
	networking.firewall.allowedTCPPorts = [ 8384 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}

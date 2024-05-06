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
				"laptop" = { id = "ZGZ5OKM-VLQE6IZ-U7SRJ3H-HY26IM4-BDLGPLA-DIQ3535-3RYE7MK-VVGZIQ4"; };
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

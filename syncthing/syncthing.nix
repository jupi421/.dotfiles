{ pkgs, ... }: 

{
	programs.syncthing = {
		enable = true;
		dataDir = "/home/jay/";
		openDefaultPorts = true;
		configDir = "/home/jay/.dotfiles/syncthing/";
		user = "wk";
		group = "users";

	};
}

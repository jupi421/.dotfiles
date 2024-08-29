{pkgs, ... }:

{
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia.modesetting.enable = true;

	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;

	environment.systemPackages = with pkgs; [
		mangohud
		dconf
		dconf-editor
	];

	services.dbus.enable = true;

	programs.gamemode.enable = true;
}

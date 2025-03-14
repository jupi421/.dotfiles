{pkgs, config, ... }:

{
	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};

		nvidia = {
			open = true;
			nvidiaSettings = true;
			modesetting.enable = true;
			powerManagement.enable = false;
		};
	};
		
	services.xserver.videoDrivers = ["nvidia"];

	environment.systemPackages = with pkgs; [
		dconf
		dconf-editor
	];

	services.dbus.enable = true;

	programs.coolercontrol.enable = true;
	programs.coolercontrol.nvidiaSupport = true;
}

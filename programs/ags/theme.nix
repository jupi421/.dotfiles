{ pkgs, config, ... }:

let
	cursorTheme = {
		name = "Qogir";
		size = 24;
		package = pkgs.qogir-icon-theme;
	};
	iconTheme = {
		name = "MoreWaita";
		package = pkgs.morewaita-icon-theme;
	};
in {
	home = {
		packages = with pkgs; [
			iconTheme.package
			cantarell-fonts
			adwaita-icon-theme
			papirus-icon-theme
		];
	};
}

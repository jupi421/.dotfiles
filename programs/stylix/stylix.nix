{pkgs, ... }:

{
	stylix = {
		enable = true;

		base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
		polarity = "dark";
		image = /home/jay/Pictures/Wallpapers/Mountains.jpg;

		fonts = {
			monospace = {
				package = pkgs.iosevka;
				name = "Iosevka";
			};
			sizes = {
				terminal = 10;
				applications = 10;
			};
		};

		targets.neovim.enable = false;
	};
}

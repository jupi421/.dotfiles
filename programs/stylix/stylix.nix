{pkgs, inputs, ... }:

{
	imports = [ inputs.stylix.homeManagerModules.stylix ];

	stylix = {
		enable = true;

		base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
		polarity = "dark";
		image = ../../Wallpapers/Mountains-Nord.jpg;

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

		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Ice";
			size = 20;
		};

		targets = {
			neovim.enable = false;
			hyprland.enable = true;
		};
	};
}

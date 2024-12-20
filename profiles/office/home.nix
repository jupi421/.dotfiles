{config, pkgs, inputs, ... }:

{
	imports = [
		../../programs/tmux/tmux.nix
		../../programs/nvim/nvim.nix
		../../programs/zsh/zsh.nix
		../../programs/hyprland/hyprland.nix
		../../programs/stylix/stylix.nix
		../../programs/waybar/waybar.nix
		../../programs/kitty/kitty.nix
	];
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "jay";
	home.homeDirectory = "/home/jay";

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "23.11"; # Please read the comment before changing.

	# The home.packages option allows you to install Nix packages into your
	# environment.

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	home.packages = with pkgs; [
		blueman
		brightnessctl
		chromium
		dmenu
		dunst
		fd
		feh
		firefox
		flameshot
		fluent-reader
		fzf
		gdb
		gnuplot
		htop
		kitty
		xfce.thunar
		nitrogen
		notify
		obsidian
		ovito
		picom
		qalculate-gtk
		ripgrep
		rofi
		sassc
		sshfs
		spotify
		starship
		libreoffice-qt
		texliveFull
		teams-for-linux
		tree
		vesktop
		wl-clipboard
		xournalpp
		zathura
		zip
		zoom-us
		zotero
		zoxide

		kdePackages.dolphin
		kdePackages.qtsvg

		nomachine-client

# fonts
		font-awesome
		iosevka
		nerdfonts
		#terminus-nerdfont
	];

	fonts.fontconfig.enable = true;

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		".config/dunst".source = ../../programs/dunst;
		".config/rofi".source = ../../programs/rofi;
		#".config/zathura".source = ../../programs/zathura;
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. If you don't want to manage your shell through Home
	# Manager then you have to manually source 'hm-session-vars.sh' located at
	# either
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/jay/etc/profile.d/hm-session-vars.sh
	#

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

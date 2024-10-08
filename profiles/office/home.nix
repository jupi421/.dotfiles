{config, pkgs, inputs, ... }:

{
	imports = [
		../../programs/tmux/tmux.nix
		../../programs/nvim/nvim.nix
		../../programs/zsh/zsh.nix
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

	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
		nix-direnv.enable = true;
	};

	programs.zsh = {
		enable = true;
	};

	programs.zsh.enableCompletion = true;
	home.sessionVariables.SHELL = pkgs.zsh;

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
	};

	home.packages = with pkgs; [
		blueman
		brightnessctl
		dmenu
		dunst
		fd
		#	inputs.tmux-sessionx.packages.x86_64-linux.default

		firefox
		flameshot
		fzf
		feh
		gdb
		gnuplot
		htop
		kitty
		tree
		picom
		qalculate-gtk
		python311Packages.qtile
		ovito
		ripgrep
		rofi
		sassc
		starship
		texliveFull
		nitrogen
		notify
		wmctrl
		xclip
		xorg.xprop
		xournalpp
		zoxide
		zsh
		zathura
		zotero
		zip

		chromium

		# fonts
		iosevka
		terminus-nerdfont
		nerdfonts
		font-awesome
	];

	fonts.fontconfig.enable = true;

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		".config/qtile".source = ../../programs/qtile;
		".config/picom".source = ../../programs/picom;
		".config/kitty".source = ../../programs/kitty;
		".config/dunst".source = ../../programs/dunst;
		".config/rofi".source = ../../programs/rofi;
		".config/zathura".source = ../../programs/zathura;
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

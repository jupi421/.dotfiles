{config, pkgs, inputs, ... }:
let
	ovitoOverlay = (builtins.getFlake "/home/jay/.dotfiles/programs/extern/ovito").overlays.default;
in {

	imports = [
		../../programs/tmux/tmux.nix
		../../programs/nvim/nvim.nix
		../../programs/zsh/zsh.nix
		../../programs/stylix/stylix.nix
		../../programs/waybar/waybar.nix
		../../programs/kitty/kitty.nix
	];
	
	home.username = "jay";
	home.homeDirectory = "/home/jay";

	home.stateVersion = "23.11"; # Please read the comment before changing.

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	nixpkgs.overlays = [ ovitoOverlay ];

	home.packages = with pkgs; [
		beeper
		blueman
		btop
		brightnessctl
		dmenu
		dunst
		fd
		firefox
		fzf
		gdb
		gnuplot
		htop
		kitty
		ovito
		xfce.thunar
		notify
		jmol
		lima
		pavucontrol
		picom
		qalculate-gtk
		ripgrep
		rofi
		sshfs
		starship
		step-cli	
		texliveFull
		networkmanagerapplet
		teams-for-linux
		telegram-desktop
		tree
		vesktop
		whatsapp-for-linux
		wl-clipboard
		xournalpp
		zathura
		zip
		zoom-us
		zotero
		zoxide

		# fonts
		nerd-fonts.symbols-only
		iosevka
	];

	fonts = {
		fontconfig.enable = true;
	};

	home.file = {
		".config/dunst".source = ../../programs/dunst;
		".config/rofi".source = ../../programs/rofi;
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

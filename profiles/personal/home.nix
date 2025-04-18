{config, pkgs, inputs, ... }:

{
	imports = [
		../../programs/tmux/tmux.nix
		../../programs/nvim/nvim.nix
		../../programs/zsh/zsh.nix
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
#
	home.packages = with pkgs; [
		beeper
		blueman
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
		xfce.thunar
		notify
		ovito
		jmol
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

{config, pkgs, ... }:

{
  imports = [
	inputs.xremap-flake.homeManagerModules.default
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

  services.xremap = {
	  withX11 = true;
	  config = {
		modmap = [
			name = "global capslock to ctrl";
			remap = { "CapsLock" = "CTRL_L"; };
		];
	  };
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
	eww
	fd
	fzf
	firefox
	flameshot
	htop
	kitty
	obsidian
	picom
	qtile
	ripgrep
	rofi
	sassc
	starship
	steam-run
	spotify
	teams-for-linux
	telegram-desktop
	neofetch
	neovim
	nitrogen
	notify
	whatsapp-for-linux
	webcord
	wmctrl
	xclip
	xorg.xprop
	xournalpp
	zoxide
	zsh

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
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /home/jay/.dotfiles/nvim;
	".config/qtile".source = ./qtile;
	".config/picom".source = ./picom;
	".config/eww".source = ./eww;
	".config/kitty".source = ./kitty;
	".config/dunst".source = ./dunst;
	".config/rofi".source = ./rofi;
	".config/zathura".source = ./zathura;
	".zshrc".source = ./.zshrc;
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

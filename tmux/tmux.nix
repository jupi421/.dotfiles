{ pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		shell = "${pkgs.zsh}/bin/zsh";
		prefix = "C-Space";
		mouse = true;
		plugins = with pkgs; [
			{
				plugin = tmuxPlugins.catppuccin;
				extraConfig = '' 
					set -g @catppuccin_flavor 'mocha'
					set -g @catppuccin_window_tabs_enabled on
					set -g @catppuccin_date_time "%H:%M"
				'';
			}
			{
				plugin = tmuxPlugins.sensible;
			}
		];
		extraConfig = '' 
			# navigation between windows
			bind -n M-H previous-window
			bind -n M-L next-window

			# window indexing from 1
			set -g base-index 1
			set -g pane-base-index 1
			set-window-option -g pane-base-index 1
			set-option -g renumber-windows on
		'';
	};
}

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
			tmuxPlugins.sensible
			tmuxPlugins.yank

		];
		extraConfig = '' 
			# navigation between windows
			bind -n M-H previous-window
			bind -n M-L next-window

			# bar config
			#set -g status-right "#[fg=b4befe, bold, bg=#1e1e2e]%a %d-%m-%Y %l:%M %p"
			#set -g status-justify left-length 200
			#set -g status-justify right-length 200
			set -g status-position top
			set -g status-style 'bg=#1e1e2e'
			
			set -g window-status-current-format '#[fg=magenta, bg=#1e1e2e] *#I #W'
			set -g window-status-format '#[fg=grey, bg=#1e1e2e] #I #W'
			set -g window-status-last-style 'fg=white, bg=black'

			# window indexing from 1
			set -g base-index 1
			set -g pane-base-index 1
			set-window-option -g pane-base-index 1
			set-option -g renumber-windows on
		'';
	};
}

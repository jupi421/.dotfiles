{ pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		shell = "${pkgs.zsh}/bin/zsh";
		terminal = "tmux-256-color";
		historyLimit = 100000;
		plugins = with pkgs; [
			{
				plugin = tmuxPlugins.catppuccin;
				extraConfig = '' 
					set -g @catppuccin_flavor 'mocha'
					set -g @catppuccin_window_tabs_enabled on
					set -g @catppuccin_date_time "%H:%M"
				'';
			}
		];
	};
}

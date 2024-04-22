{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			catppuccin-nvim
		];
		extraLuaConfig = /* lua */ '' 
			require("catppuccin").setup({
				color_overrides = {
					mocha = {
						base = '#13111f'
					}
				}
			})
			vim.cmd("colorscheme catppuccin-mocha")

			vim.opt.termguicolors = true
		'';
	};
}

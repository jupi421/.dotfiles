{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			catppuccin-nvim
		];
		extraLuaConfig = /* lua */ '' 
			function Colorscheme(color)
				color = color or "catppuccin-mocha"
				vim.cmd.colorscheme(color)


				require("catppuccin").setup({
					color_overrides = {
						mocha = {
							base = '#13111f'
						}
					}
				})

				vim.cmd("colorscheme catppuccin-mocha")
				Colorscheme()
				end
		'';
	};
}

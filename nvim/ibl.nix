{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			indent-blankline-nvim
		];
		extraLuaConfig = /* lua */ ''
			require("ibl").setup({
				scope = {
					show_start = false,
					show_end = false,
				}
			})
		'';
	};
}

{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			vimtex
		];
		extraLuaConfig = /* lua */ ''
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_compiler_method = "latexmk"
		'';
	};
}
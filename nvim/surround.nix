{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			nvim-surround
		];
		extraLuaConfig = /* lua */ ''
			require("nvim-surround").setup({})
		'';
	};
}

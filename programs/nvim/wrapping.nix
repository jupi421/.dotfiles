{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			wrapping-nvim
		];
		extraLuaConfig = /* lua */ ''
			require("wrapping").setup()
		'';
	};
}

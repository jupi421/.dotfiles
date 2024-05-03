{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			nvim-autopairs
		];
		extraLuaConfig = /* lua */ ''
			require("nvim-autopairs").setup {}
		'';
	};
}

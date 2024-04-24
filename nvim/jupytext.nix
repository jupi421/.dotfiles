{ pkgs, ... }:

{
	home.packages = with pkgs; [
		python311Packages.jupytext
	]; 

	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			jupytext-nvim
		];
		extraLuaConfig = /* lua */ ''
			require("jupytext").setup({
				style = "markdown",
				output_extension = "md",
				force_ft = "markdown",
			})
		'';
	};
}

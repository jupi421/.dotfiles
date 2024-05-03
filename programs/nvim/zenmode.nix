{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			zen-mode-nvim
		];
		extraLuaConfig = /* lua */ ''
			require("zen-mode").setup()
			vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>")
		'';
	};
}

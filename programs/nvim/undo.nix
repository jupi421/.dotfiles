{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			telescope-undo-nvim
		];
		extraLuaConfig = /* lua */ ''
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
			vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
		'';
	};
}

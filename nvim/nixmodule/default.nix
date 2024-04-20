{ config, pkgs, ... }:

{
	imports = [
		./colorscheme.nix
	];

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		plugins = with pkgs.vimPlugins; [
			nvim-treesitter.withAllGrammars
			plenary-nvim
			nvim-autopairs
			harpoon2
			indent-blankline-nvim
			lsp-zero-nvim
			lualine-nvim
			luasnip
			neogen
			obsidian-nvim
			nvim-surround
			telescope-nvim
			trouble-nvim
			telescope-undo-nvim
			vimtex
			wrapping-nvim
			zen-mode-nvim
		];
	};
}

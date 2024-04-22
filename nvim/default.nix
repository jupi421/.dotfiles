{ config, pkgs, ... }:

{
	imports = [
		./colorscheme.nix
		./autopairs.nix
		./harpoon.nix
		./ibl.nix
		./lualine.nix
		./luasnip.nix
		./lsp
		./neogen.nix
		./surround.nix
		./telescope.nix
		./trouble.nix
		./treesitter.nix
		./undo.nix
		./vimtex.nix
		./wrapping.nix
		./remap.nix
	];
	
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		plugins = with pkgs.vimPlugins; [
			nvim-web-devicons
			plenary-nvim
			obsidian-nvim
		];
	};

}

{ pkgs, ... }:

{
	programs.neovim = {
		plugins = let
			nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins:
				with treesitter-plugins; [
					bash
					c
					cpp
					lua
					python
					java
					markdown
					nix
					rust
					query
				]);
		in
			with pkgs.vimPlugins; [
				nvim-treesitter-with-plugins
			];
			extraLuaConfig = /* lua */ ''
				require("nvim-treesitter.configs").setup({
					auto_install = false,

					indent = {
						enable = true
					},

					highlight = {
						-- `false` will disable the whole extension
						enable = true,

						-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
						-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
						-- Using this option may slow down your editor, and you may see some duplicate highlights.
						-- Instead of true it can also be a list of languages
						additional_vim_regex_highlighting = false,
						disable = { "latex" },
					},
				})
			'';
	};
}

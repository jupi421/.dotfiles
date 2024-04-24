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
				nvim-treesitter-textobjects
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

					-- ... other ts config
					textobjects = {
						move = {
							enable = true,
							set_jumps = false, -- you can change this if you want.
							goto_next_start = {
								--- ... other keymaps
								["]b"] = { query = "@code_cell.inner", desc = "next code block" },
							},
							goto_previous_start = {
								--- ... other keymaps
								["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
							},
						},
						select = {
							enable = true,
							lookahead = true, -- you can change this if you want
							keymaps = {
								--- ... other keymaps
								["ib"] = { query = "@code_cell.inner", desc = "in block" },
								["ab"] = { query = "@code_cell.outer", desc = "around block" },
							},
						},
						swap = { -- Swap only works with code blocks that are under the same
								 -- markdown header
							enable = true,
							swap_next = {
								--- ... other keymap
								["<leader>sbl"] = "@code_cell.outer",
							},
							swap_previous = {
								--- ... other keymap
								["<leader>sbh"] = "@code_cell.outer",
							},
						},
					}
				})
			'';
	};
	home.file.".config/nvim/after/queries/markdown/textobjects.scm".text = ''
		(fenced_code_block (code_fence_content) @code_cell.inner) @code_cell.outer
	'';
}

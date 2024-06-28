{ pkgs, ... }:

{
	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			trouble-nvim
		];
		extraLuaConfig = /* lua */ ''
			require("trouble").setup({
				icons = false,
			})

			vim.keymap.set("n", "<leader>tt", function()
				require("trouble").toggle()
			end)

			vim.keymap.set("n", "[t", function()
				require("trouble").next({skip_groups = true, jump = true});
			end)

			vim.keymap.set("n", "]t", function()
				require("trouble").previous({skip_groups = true, jump = true});
			end)

			local actions = require("telescope.actions")
			local trouble = require("trouble.sources.telescope")

			local telescope = require("telescope")

			telescope.setup {
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
			}
		'';
	};
}

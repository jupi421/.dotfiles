{ pkgs, ... }:

{
	home.packages = with pkgs; [
		clang-tools
		pyright
		nil
	];

	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			nvim-lspconfig
			lsp-zero-nvim
		];
		extraLuaConfig = /* lua */ ''
			local lsp_zero = require('lsp-zero')

			lsp_zero.on_attach(function(client, bufnr)
				local opts = {buffer = bufnr, remap = false}

				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
				vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
				vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
				vim.keymap.set("n", "<leader>vdn", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>vdp", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
				vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
				-- vim.keymap.set("i", "<leader>vsh", function() vim.lsp.buf.signature_help() end, opts)
			end)

			lsp_zero.setup_server({'pyright', 'clangd'})
				
			cmp.setup({
				sources = {
					{name = 'path'},
					{name = 'nvim_lsp'},
					{name = 'nvim_lua'},
					{name = 'luasnip', keyword_length = 2},
					{name = 'buffer', keyword_length = 3},
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-h>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
			})
		'';
	};
}

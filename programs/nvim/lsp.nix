{ pkgs, ... }:

{
	home.packages = with pkgs; [
		clang-tools
		pyright
		nil
		texlab
	];

	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			nvim-lspconfig
			lsp-zero-nvim
			nvim-cmp
			cmp-nvim-lsp
			cmp-buffer
			cmp-path
			cmp_luasnip
			cmp-nvim-lua
		];
		extraLuaConfig = /* lua */ ''
			local lsp_zero = require('lsp-zero')

			lsp_zero.on_attach(function(client, bufnr)
				local opts = {buffer = bufnr, remap = false}

				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
				vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
				vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
				vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
				vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
				vim.keymap.set("i", "<A-k>", function() vim.lsp.buf.signature_help() end, opts)
			end)

			require("lspconfig")["clangd"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					'clangd',
					'--background-index',
					'--clang-tidy',
					'--header-insertion=never',
					'--all-scopes-completion',
					'--log=error',
				},
				root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git")
			})

			require("lspconfig")["pyright"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							diagnosticSeverityOverrides = {
								reportUnusedExpression = "none",
							},
						},
					},
				},
			})

			require'lspconfig'.texlab.setup{}
								
			local cmp = require('cmp')
			local cmp_select = {behavior = cmp.SelectBehavior.Select}
			
			require('luasnip.loaders.from_vscode').lazy_load()

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

return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
		require('telescope').setup({})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
		vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ff', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}

require('venv-selector').setup {

}

vim.keymap.set("n", "<leader>v", vim.cmd.VenvSelect)

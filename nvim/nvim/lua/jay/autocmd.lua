--local augroup = vim.api.nvim_create_augroup
--local autocmd = vim.api.nvim_create_autocmd

-- Set indentation to 2 spaces
--augroup('setIndent', { clear = true })
--autocmd('Filetype', {
--group = 'setIndent',
--pattern = { 'c', 'cpp', 'tex', 'lua'
--},
--command = 'setlocal shiftwidth=2 tabstop=2'
--})
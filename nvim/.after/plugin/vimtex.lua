vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_compiler_method = "latexmk"

vim.keymap.set("n", "<leader>q", "<cmd>VimtexCompile<cr>")
vim.keymap.set("n", "<leader>ss", "<cmd>VimtexCompile<cr>")

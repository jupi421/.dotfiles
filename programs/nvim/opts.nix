{ pkgs, ... }:

{
	programs.neovim = {
		extraLuaConfig = /* lua */ ''

			vim.opt.nu = true
			vim.opt.relativenumber = true

			vim.opt.smartindent = true

			vim.opt.hlsearch = false
			vim.opt.incsearch = true

			vim.opt.scrolloff = 8

			vim.opt.updatetime = 50

			vim.opt.tabstop = 4
			vim.opt.softtabstop = 4
			vim.opt.shiftwidth = 0
		'';
	};
}

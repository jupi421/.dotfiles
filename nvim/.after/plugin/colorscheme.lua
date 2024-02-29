require("catppuccin").setup{
	color_overrides = {
		mocha = {
			base = '#13111f'
		}
	}
}

function Colorscheme(color)
	color = color or "catppuccin-mocha"
	vim.cmd.colorscheme(color)
end

Colorscheme()

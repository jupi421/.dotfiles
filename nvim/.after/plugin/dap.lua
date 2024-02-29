local dap = require('dap')
local dapui = require("dapui")
require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
--dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

--cpp
dap.adapters.executable = {
	type = 'executable',
	name = 'lldb1',
	host = '127.0.0.1',
	port = 13000
}
dap.adapters.codelldb = {
	type = 'server',
	name = 'codelldb-server',
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
		args = {"--port", "${port}"},
	}
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}

dap.configurations.rust = dap.configurations.cpp

dap.configurations.c = dap.configurations.cpp

--keybindings
vim.keymap.set("n", "<F8>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F9>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_back()<CR>")

vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>cb", ":lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")

vim.keymap.set("n", "<leader>db", ":lua require'dapui'.toggle()<CR>")


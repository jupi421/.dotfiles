{ pkgs, ... }:
{
	home.packages = with pkgs; [
		vscode-extensions.vadimcn.vscode-lldb
	];

	programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			nvim-dap
			nvim-dap-ui
			nvim-dap-virtual-text
		];
		extraLuaConfig = /* lua */ ''
			local dap   = require("dap")
			local dapui = require("dapui")

			dapui.setup({})
			require("nvim-dap-virtual-text").setup({})

			-- Nix paths for CodeLLDB
			local codelldb = [[${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb]]
			local liblldb  = [[${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so]]

			dap.adapters.codelldb = {
				type = "executable",
				command = codelldb,
				args = { "--liblldb", liblldb },
			}

			dap.configurations.cpp = {
				{
					name = "Launch (pick binary)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = vim.fn.getcwd(),
					stopOnEntry = false,
					showDisassembly = "never"
				},
			}
			dap.configurations.c    = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			vim.keymap.set("n", "<space>b",  dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
			vim.keymap.set("n", "<space>e",  function() require("dapui").eval(nil, { enter = true }) end)
			vim.keymap.set("n", "<space>cb", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
			vim.keymap.set('n', '<leader>db', function() require('dap').clear_breakpoints() end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_back)
			vim.keymap.set("n", "<F3>", dap.restart)
			vim.keymap.set("n", "<F4>", dap.step_into)
			vim.keymap.set("n", "<F5>", dap.step_over)
			vim.keymap.set("n", "<F6>", dap.step_out)

			-- Auto open/close DAP UI
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			vim.opt.signcolumn = "yes"
			vim.fn.sign_define("DapBreakpoint",         { text = "●" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "◌" })
			vim.fn.sign_define("DapStopped",            { text = "▶" })
		'';
	};
}

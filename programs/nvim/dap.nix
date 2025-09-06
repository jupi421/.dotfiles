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
			local dap = require "dap"
			local dapui = require "dapui"

			dapui.setup{}
			require("nvim-dap-virtual-text").setup{}

			local codelldb = [[${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb]]
			local liblldb  = [[${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so]]

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb,
					args = {"--port", "${port}"},
					detached = false
				}
			}

			dap.configurations.cpp = {
			  {
				name = "cmake",
				type = "codelldb",
				request = "launch",
				program = function()
				  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = false,
			  },
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

			vim.keymap.set("n", "<leader>e", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F6>", dap.restart)

			dap.listeners.before.attach.dapui_config = function()
				dapui.open{}
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		'';
	};
}

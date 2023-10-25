return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "/usr/sbin/codelldb",
					args = { "--port", "${port}" },
				},
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			local function map(mode, lhs, rhs, opts)
				local options = { noremap = true }
				if opts then
					options = vim.tbl_extend("force", options, opts)
				end
				vim.api.nvim_set_keymap(mode, lhs, rhs, options)
			end

			map("n", "<F5>", ":lua require'dap'.continue()<CR>", { silent = true })
			map("n", "<F10>", ":lua require'dap'.step_over()<CR>", { silent = true })
			map("n", "<F11>", ":lua require'dap'.step_into()<CR>", { silent = true })
			map("n", "<F12>", ":lua require'dap'.step_out()<CR>", { silent = true })
			map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
			map(
				"n",
				"<leader>bc",
				":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				{ silent = true }
			)
			map(
				"n",
				"<leader>l",
				":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				{ silent = true }
			)

			-- dap-ui key map
			map("n", "<leader>d", ":lua require'dapui'.toggle()<CR>", { silent = true })
			map("n", "<leader><leader>df", ":lua require'dapui'.eval()<CR>", { silent = true })

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f38ba8" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		config = true,
	},
}

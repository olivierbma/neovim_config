return {

	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		--dap-ui dapui setup

		require("dapui").setup({
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = ""
				}
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" }
				}
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = ""
			},
			layouts = { {
				elements = { {
					id = "scopes",
					size = 0.8
				}, {
					id = "stacks",
					size = 0.2
				}, },
				position = "left",
				size = 40
			}, {
				elements = { {
					id = "console",
					size = 0.66
				}, {
					id = "repl",
					size = 0.34
				}, },
				position = "bottom",
				size = 10
			} },
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t"
			},
			render = {
				indent = 1,
				max_value_lines = 100
			}
		}
		)


		vim.keymap.set("n", "<F9>", require('dap').toggle_breakpoint,
			{ desc = 'Add or remove a breakpoint to a line' })
		vim.keymap.set("n", "<F10>", require('dap').step_over, { desc = 'Execute function as a single command' })
		vim.keymap.set("n", "<F11>", require('dap').step_into, { desc = 'Execute line and go to the next one' })


		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set('n', 'dq', dapui.close, { desc = "[D]ap-ui [Q]uit" })
	end
}

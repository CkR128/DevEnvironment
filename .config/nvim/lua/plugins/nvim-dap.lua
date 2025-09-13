-- stylua: ignore
-- local function linkKeybindings()
-- 	vim.keymap.set("n", "<leader>da", function() require('dap').continue() end, { desc = "DAP - Continue" })
-- 	vim.keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "DAP - Toggle Breakpoint" })
-- 	vim.keymap.set("n", "<leader>dB", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "DAP - Conditional Breakpoint" })
-- 	vim.keymap.set("n", "<leader>dd", function() require('dap').continue() end, { desc = "DAP - Continue" })
-- 	vim.keymap.set("n", "<leader>dh", function() require('dapui').eval() end, { desc = "DAP - Evaluate" })
-- 	vim.keymap.set("n", "<leader>di", function() require('dap').step_into() end, { desc = "DAP - Step Into" })
-- 	vim.keymap.set("n", "<leader>do", function() require('dap').step_out() end, { desc = "DAP - Step Out" })
-- 	vim.keymap.set("n", "<leader>dO", function() require('dap').step_over() end, { desc = "DAP - Step Over" })
-- 	vim.keymap.set("n", "<leader>dt", function() require('dap').terminate() end, { desc = "DAP - Terminate" })
-- 	vim.keymap.set("n", "<leader>du", function() require('dapui').open() end, { desc = "DAP - Open UI" })
-- 	vim.keymap.set("n", "<leader>dc", function() require('dapui').close() end, { desc = "DAP - Close UI" })
-- 	vim.keymap.set("n", "<leader>dw", function() require('dapui').float_element('watches', { enter = true }) end,          { desc = "DAP - Watches" })
-- 	vim.keymap.set("n", "<leader>ds", function() require('dapui').float_element('scopes', { enter = true }) end,           { desc = "DAP - Scopes" })
-- 	vim.keymap.set("n", "<leader>dr", function() require('dapui').float_element('repl', { enter = true }) end,             { desc = "DAP - REPL" })
-- end
local function resolve_lhs(lhs)
	return lhs:gsub("<leader>", vim.g.mapleader or "\\")
end
local function remove_keybinding(mode, lhs)
	local keymaps = vim.api.nvim_get_keymap(mode)
	for _, map in ipairs(keymaps) do
		if map.lhs == resolve_lhs(lhs) then
			vim.keymap.del(mode, resolve_lhs(lhs))
			vim.notify("Removed keymap: " .. lhs)
			return
		end
	end
	-- Optionally notify or ignore
	vim.notify("Keymap not found: " .. lhs, vim.log.levels.DEBUG)
end
-- stylua: ignore
local function removeKeybindings()
	-- remove_keybinding("n", "<leader>da")
	-- vim.keymap.del("n", " db", { desc = "DAP - Toggle Breakpoint" })
	-- vim.keymap.del("n", "<Leader>dB", { desc = "DAP - Conditional Breakpoint" })
	-- vim.keymap.del("n", "<Leader>dd", { desc = "DAP - Continue" })
	-- vim.keymap.del("n", "<Leader>dh", { desc = "DAP - Evaluate" })
	-- vim.keymap.del("n", "<Leader>di", { desc = "DAP - Step Into" })
	-- vim.keymap.del("n", "<Leader>do", { desc = "DAP - Step Out" })
	-- vim.keymap.del("n", "<Leader>dO", { desc = "DAP - Step Over" })
	-- vim.keymap.del("n", "<Leader>dt", { desc = "DAP - Terminate" })
	-- vim.keymap.del("n", "<Leader>du", { desc = "DAP - Open UI" })
	-- vim.keymap.del("n", "<Leader>dc", { desc = "DAP - Close UI" })
	-- vim.keymap.del("n", "<Leader>dw", { desc = "DAP - Watches" })
	-- vim.keymap.del("n", "<Leader>ds", { desc = "DAP - Scopes" })
	-- vim.keymap.del("n", "<Leader>dr", { desc = "DAP - REPL" })
end
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- Needed by dap-ui
			"theHamsta/nvim-dap-virtual-text",
			"mxsdev/nvim-dap-vscode-js",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
		},

		-- stylua: ignore
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_virtual_text = require("nvim-dap-virtual-text")

			-- vim.keymap.set("n", "<Leader>c",  function() require('dap').continue() end, { desc = "DAP - Continue" })
			-- vim.keymap.set("n", "<Leader>db", function() require('dap').toggle_breakpoint() end, { desc = "DAP - Toggle Breakpoint" })
			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP Virtual Text Setup                                   │
			-- ╰──────────────────────────────────────────────────────────╯
			dap_virtual_text.setup({
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
				all_references = false, -- show virtual text on all all references of the variable (not only definitions)
				filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
				-- Experimental Features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			})
			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP UI Setup                                             │
			-- ╰──────────────────────────────────────────────────────────╯
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Expand lines larger than the window
				-- Requires >= 0.7
				expand_lines = vim.fn.has("nvim-0.7"),
				-- Layouts define sections of the screen to place windows.
				-- The position can be "left", "right", "top" or "bottom".
				-- The size specifies the height/width depending on position. It can be an Int
				-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
				-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
				-- Elements are the elements shown in the layout (in order).
				-- Layouts are opened in order so that earlier layouts take priority in window sizing.
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_widthn = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
				},
			})

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP Setup                                                │
			-- ╰──────────────────────────────────────────────────────────╯
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
				linkKeybindings()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
				removeKeybindings()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
				removeKeybindings()
			end

			-- Enable virtual text
			vim.g.dap_virtual_text = true

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Icons                                                    │
			-- ╰──────────────────────────────────────────────────────────╯
			vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapConditionalBreakpoint", { text = "CB", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "P", texthl = "", linehl = "", numhl = "" })

			-- Setup mason + mason-nvim-dap
			require("mason").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = { "js" }, -- js is the alias for vscode-js-debug
				automatic_installation = true,
				handlers = {},
			})

			-- Setup nvim-dap-vscode-js
			local dap_vscode = require("dap-vscode-js")
			local debugger_path = vim.fn.stdpath("data") .. "/mason/packages/"

			dap_vscode.setup({
				node_path = "node", -- Can be set to node version in nvm or system
				debugger_path = debugger_path,
				adapters = {
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"node-terminal",
					"pwa-extensionHost",
				},
			})

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Adapters                                                 │
			-- ╰──────────────────────────────────────────────────────────╯
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter", -- As I'm using mason, this will be in the path
					args = { "${port}" },
				},
			}

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Configurations                                           │
			-- ╰──────────────────────────────────────────────────────────╯
			for _, lang in ipairs({ "javascript", "typescript" }) do
				dap.configurations[lang] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug Jest Tests",
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
				}
			end
		end,
	},
}

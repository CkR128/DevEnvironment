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
			"wojciech-kulik/xcodebuild.nvim",
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

			local xcodebuild = require("xcodebuild.integrations.dap")
			-- SAMPLE PATH, change it to your local codelldb path
			local codelldbPath = os.getenv("HOME") .. ".local/vscode-lldb/codelldb-darwin-arm64/extension/adapter/codelldb"

			xcodebuild.setup(codelldbPath)

			-- vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
			-- vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
			-- vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
			-- vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
			-- vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			-- vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
			-- vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
		end,
	},
}

-- NOTE: some debuggers need EXTRA stuff that needs to be installed outside of Mason, for example you need 'gdb' for CPP debugging
-- If you wanna add a language, you have to look up online for all the dependencies
return {
	{
		"mfussenegger/nvim-dap", -- This is the main plugin for debugging
		keys = {
			{ "<Leader>db", ":DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
			{ "<Leader>dr", ":DapContinue<CR>", desc = "Run/Continue" },
			{ "<Leader>dx", ":DapTerminate<CR>", desc = "Terminate" },
			{ "<F6>", ":DapStepOver<CR>", desc = "Step Over" },
			{ "<F7>", ":DapStepInto<CR>", desc = "Step Into" },
			{ "<F8>", ":DapStepOut<CR>", desc = "Step Out" },
			{
				"<Leader>dt",
				function()
					require("dap-view").toggle()
				end,
				desc = "Toggle UI",
			},
			{
				"<leader>dc",
				function()
					-- require and run ONLY when key is pressed
					local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")
					set_exception_breakpoints()
				end,
				desc = "[D]ebug [C]ondition breakpoints",
			},
		},
		dependencies = {
			"nvim-neotest/nvim-nio", -- Needed for dap UI
			"igorlfs/nvim-dap-view", -- Debugging UI (tabbed, single window)
			"theHamsta/nvim-dap-virtual-text", -- This shows inline values of the tracked variables in the debugger
			"nvim-telescope/telescope-ui-select.nvim", -- This is to get that nice window immediately even if we don't load Telescope plugin
			"jay-babu/mason-nvim-dap.nvim", -- This makes loading very efficient, we set the lazy = true for mason-nvim-dap
			"lucaSartore/nvim-dap-exception-breakpoints", -- This gives a widget for choosing exception handling
		},
		config = function()
			-- Setup nvim-dap-view (replaces nvim-dap-ui)
			require("dap-view").setup({
				winbar = {
					sections = { "scopes", "console", "breakpoints", "exceptions", "watches", "threads", "repl" },
					default_section = "scopes", -- use 's' to edit the value of variables
					controls = {
						enabled = true,
					},
					show_keymap_hints = false,
				},
				windows = {
					size = 0.40, -- Main window width (percentage or columns)
					position = "below", -- "below" or "above"
					terminal = {
						hide = true, -- I have moved the terminal into sections above
						-- size = 0.3, -- Terminal window width
						-- position = "right", -- "left" or "right"
					},
				},
				virtual_text = {
					enabled = false, -- I use a seperate plugin for this. It is completely the same, just the syntax color is a bit different
				},
			})

			-- Tab scroll the debugging sections
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "dap-view", "dap-view-term", "dap-repl" },
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					local ft = vim.bo[ev.buf].filetype

					local modes = { "n" } -- normal mode for all
					if ft == "dap-view-term" then
						table.insert(modes, "t") -- terminal mode for console
					elseif ft == "dap-repl" then
						table.insert(modes, "i") -- insert mode for repl
					end

					for _, mode in ipairs(modes) do
						vim.keymap.set(mode, "<Tab>", function()
							require("dap-view").navigate({ count = 1, wrap = true })
						end, opts)
						vim.keymap.set(mode, "<S-Tab>", function()
							require("dap-view").navigate({ count = -1, wrap = true })
						end, opts)
					end
				end,
			})

			-- Setup DAP Virtual Text
			require("nvim-dap-virtual-text").setup({
				commented = true, -- Show variable changes in the form of comments
				highlight_changed_variables = false, -- I said I was gonna comment as much lines as possible but CMONNN bruhhhhhh
			})

			local dap = require("dap")
			local dap_view = require("dap-view")

			-- Following functions are for auto open and close
			dap.listeners.before.attach.dapview_config = function()
				dap_view.open()
			end
			dap.listeners.before.launch.dapview_config = function()
				dap_view.open()
			end
			dap.listeners.before.event_terminated.dapview_config = function()
				dap_view.close()
			end
			dap.listeners.before.event_exited.dapview_config = function()
				dap_view.close()
			end

			-- Visuals for breakpoints and those ones that have been rejected
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
			vim.api.nvim_set_hl(0, "MyGreenArrow", { fg = "#33b959", bg = "NONE", bold = true })
			vim.fn.sign_define("DapStopped", { text = "󰜴", texthl = "MyGreenArrow", linehl = "", numhl = "" })

			-- -- Setup area, your main source should be 'https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation'
			-- -- I AM LEAVING THIS TO SHOW YOU THE FORMAT OF INPUTING YOUR OWN DAP, BUT ON THE BOTTOM IS A PLUGIN THAT DOES ALL OF THIS FOR US
			-- -- Adapters
			-- dap.adapters.cppdbg = {
			--   id = 'cppdbg',
			--   type = 'executable',
			--   command = '/home/{YOUR_USER}/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7', -- You HAVE to use absolute PATH
			-- }
			--
			-- -- Configurations
			-- dap.configurations.cpp = {
			--   {
			--     name = "Launch file",
			--     type = "cppdbg",
			--     request = "launch",
			--     program = function()
			--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			--     end,
			--     cwd = '${workspaceFolder}',
			--     stopAtEntry = true,
			--   },
			--   {
			--     name = 'Attach to gdbserver :1234',
			--     type = 'cppdbg',
			--     request = 'launch',
			--     MIMode = 'gdb',
			--     miDebuggerServerAddress = 'localhost:1234',
			--     miDebuggerPath = '/usr/bin/gdb',
			--     cwd = '${workspaceFolder}',
			--     program = function()
			--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			--     end,
			--   },
			-- }
		end,
	},
	{
		-- Now this plugin is literally goated, ALL YOU NEED TO DO is download the DAP API you want from Mason UI and that is it, this one automacitally sets up nvim to call that API
		-- I had some problems with this
		"jay-babu/mason-nvim-dap.nvim",
		lazy = true, -- We set it as lazy with no triggers, meaning it will never start without being someones dependency (it is nvim-dap's dependency)
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {},
				automatic_installation = true, -- Automacitally set up everything we download off the Mason UI
				handlers = { -- This peace of code is to enable pretty printing in debugging (for example you can see variables of vectors in cpp in watch list) OTHERWISE JUST KEEP IT AT {}
					function(config) -- default handler, keep defaults for everything else
						require("mason-nvim-dap").default_setup(config)
					end,

					cppdbg = function(config)
						-- call default setup first
						require("mason-nvim-dap").default_setup(config)

						-- then patch the config to enable pretty printing
						local dap = require("dap")
						for _, cfg in ipairs(dap.configurations.cpp or {}) do
							cfg.setupCommands = {
								{
									text = "-enable-pretty-printing",
									description = "enable pretty printing",
									ignoreFailures = false,
								},
							}
						end
					end,
				}, -- You actually need to at least have handlers = {} for it to load the defaults
			})
		end,
	},
	-- Very cool plugin to toggle which exceptions will be handled
	{
		"lucaSartore/nvim-dap-exception-breakpoints",
		dependencies = { "mfussenegger/nvim-dap" },
		commit = "1a71c18",
		lazy = true,
		config = function()
			local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")

			vim.api.nvim_set_keymap(
				"n",
				"<leader>dc",
				"",
				{ desc = "[D]ebug [C]ondition breakpoints", callback = set_exception_breakpoints }
			)
		end,
	},
}

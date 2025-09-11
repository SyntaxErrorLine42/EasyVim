-- NOTE: some debuggers need EXTRA stuff that needs to be installed outside of Mason, for example you need 'gdb' for CPP debugging
-- If you wanna add a language, you have to look up online for all the dependencies
return {
	{
		"mfussenegger/nvim-dap", -- This is the main plugin for debugging
		dependencies = {
			"nvim-neotest/nvim-nio", -- Needed for dap UI
			"rcarriga/nvim-dap-ui", -- Debugging UI this shit hella cool
			"theHamsta/nvim-dap-virtual-text", -- This shows inline values of the tracked variables in the debugger
		},
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
			-- Also an extremely important feature, inside of DAP UI you can go to expressions and press 'a' to add your custom expressions to watch

			-- Setup DAP Virtual Text
			require("nvim-dap-virtual-text").setup({
				commented = true, -- Show variable changes in the form of comments
				highlight_changed_variables = false, -- I said I was gonna comment as much lines as possible but CMONNN bruhhhhhh
			})

			-- Following funcitons are for auto open and close
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
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

			-- Some keybindings that we are gonna use in the debugger
			vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>dr", ":DapContinue<CR>", { desc = "Run/Continue" })
			vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "Terminate" })
			vim.keymap.set("n", "<F6>", ":DapStepOver<CR>", { desc = "Step Over" })
			vim.keymap.set("n", "<F7>", ":DapStepInto<CR>", { desc = "Step Into" })
			vim.keymap.set("n", "<F8>", ":DapStepOut<CR>", { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dt", function()
				require("dapui").toggle()
			end, { desc = "Toggle UI" })

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
		config = function()
			require("mason-nvim-dap").setup({
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
}

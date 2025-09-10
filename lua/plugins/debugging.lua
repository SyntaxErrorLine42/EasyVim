return {
	{
		"mfussenegger/nvim-dap", -- This is the main plugin for debuging
		dependencies = {
			"leoluz/nvim-dap-go", -- This is how you are gonna be importing debuggers per language, for example this one is for Go
			"rcarriga/nvim-dap-ui", -- UI bruh
		},
		config = function()
			require("dapui").setup()
			require("dap-go").setup()

			local dap, dapui = require("dap"), require("dapui")

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

			vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
			vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
			vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
		end,
	},
	{
    "jay-babu/mason-nvim-dap.nvim",
    require("mason-nvim-dap").setup({
      automatic_installation = false,
    })
  },
}

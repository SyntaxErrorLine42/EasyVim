return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	keys = {
		{
			"<leader>ct",
			function()
				local client = require("copilot.client")
				local command = require("copilot.command")
				if client.is_disabled() then
					command.enable()
					vim.api.nvim_set_keymap(
						"i",
						"<Tab>",
						"v:lua.require('copilot.suggestion').accept()",
						{ expr = true, noremap = true }
					)
					print("Copilot suggestions: ON")
				else
					command.disable()
					pcall(vim.api.nvim_del_keymap, "i", "<Tab>")
					print("Copilot suggestions: OFF")
				end
			end,
			desc = "Toggle Copilot suggestions",
		},
	},
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true, -- enable it, but copilot starts disabled below
			},
			panel = { enabled = false },
		})
		-- start disabled globally via the official command API
		require("copilot.command").disable()
	end,
}

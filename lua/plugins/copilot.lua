return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	keys = {
		{
			"<leader>ct",
			function()
				-- toggle state variable
				vim.g.copilot_enabled = not vim.g.copilot_enabled

				if vim.g.copilot_enabled then
					require("copilot.suggestion").toggle_auto_trigger()

					-- map <Tab> to accept Copilot suggestions
					vim.api.nvim_set_keymap(
						"i",
						"<Tab>",
						"v:lua.require('copilot.suggestion').accept()",
						{ expr = true, noremap = true }
					)

					print("Copilot suggestions: ON")
				else
					require("copilot.suggestion").toggle_auto_trigger()

					-- restore default <Tab> behavior
					vim.api.nvim_del_keymap("i", "<Tab>")

					print("Copilot suggestions: OFF")
				end
			end,
			desc = "Toggle Copilot suggestions",
		},
	},
	config = function()
		vim.g.copilot_enabled = false -- start disabled

		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false,
			},
			panel = { enabled = false },
		})
	end,
}

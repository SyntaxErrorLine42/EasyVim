return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp", -- optional (NES)
	},
	keys = {
		{
			"<leader>ct",
			function()
				require("copilot.suggestion").toggle_auto_trigger()
			end,
			desc = "Toggle Copilot suggestions",
		},
	},
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false, -- We use <leader>ct to toggle the inline suggestions, that is why it's false in init
				keymap = {
					accept = "<Tab>",
				},
			},
			panel = {
				enabled = false,
			},
		})
	end,
}
